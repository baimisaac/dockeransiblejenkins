pipeline {
    agent any
    tools {
        maven 'maven3'
    }
    environment {
        DOCKER_TAG = getVersion()
    }
    options {
        beforeAgent {
            // Configure Git to treat the directory as safe
            sh 'git config --global --add safe.directory /var/jenkins_home/workspace/DevOps HandsOn Test_Ibrahim'
        }
    }
    stages {
        stage('SCM') {
            steps {
                git credentialsId: 'githubuser', 
                    url: 'https://github.com/baimisaac/dockeransiblejenkins.git'
            }
        }
        
        stage('Maven Build') {
            steps {
                sh "mvn clean package"
            }
        }
        
        stage('Docker Build') {
            steps {
                sh "docker build . -t baimisaac01/ibrahim:${DOCKER_TAG}"
            }
        }
        
        stage('DockerHub Push') {
            steps {
                withCredentials([string(credentialsId: 'docker-hub', variable: 'dockerHubPwd')]) {
                    sh "docker login -u baimisaac01 -p ${dockerHubPwd}"
                }
                
                sh "docker push baimisaac01/ibrahim:${DOCKER_TAG}"
            }
        }
        
        stage('Docker Deploy') {
            steps {
                withCredentials([string(credentialsId: 'sudo-password', variable: 'SUDO_PASSWORD')]) {
                    ansiblePlaybook credentialsId: 'dev-server', disableHostKeyChecking: true, 
                        extras: "-e DOCKER_TAG=${DOCKER_TAG} --extra-vars 'ansible_become_pass=${SUDO_PASSWORD}'",
                        installation: 'ansible', 
                        inventory: 'dev.inv', 
                        playbook: 'deploy-docker.yml'
                }
            }
        }
    }
}

def getVersion() {
    def commitHash = sh(label: '', returnStdout: true, script: 'git rev-parse --short HEAD')
    return commitHash.trim()
}
