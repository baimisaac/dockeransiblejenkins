pipeline {
    agent any
    tools {
        maven 'maven3'
    }
    environment {
        DOCKER_TAG = getVersion()
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
                sh "docker build . -t baimisaac01/dictionary:${DOCKER_TAG} "
            }
        }
        
        stage('DockerHub Push') {
            steps {
                withCredentials([string(credentialsId: 'docker-hub', variable: 'dockerHubPwd')]) {
                    sh "echo ${dockerHubPwd} | docker login -u baimisaac01 --password-stdin"
                }
                
                sh "docker push baimisaac01/dictionary:${DOCKER_TAG} "
            }
        }
        
        stage('Docker Deploy') {
            steps {
                withCredentials([sshUserPrivateKey(credentialsId: 'dev-server', keyFileVariable: 'SSH_KEY')]) {
                    ansiblePlaybook(
                        credentialsId: 'dev-server',
                        disableHostKeyChecking: true,
                        extras: "-e DOCKER_TAG=${DOCKER_TAG}",
                        installation: 'ansible',
                        inventory: 'dev.inv',
                        playbook: 'deploy-docker.yml'
                    )
                }
            }
        }
    }
}

def getVersion() {
    def commitHash = sh(label: '', returnStdout: true, script: 'git rev-parse --short HEAD').trim()
    return commitHash
}
