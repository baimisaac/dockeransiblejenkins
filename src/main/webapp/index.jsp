<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Silkscreen">
    <title>Rock | Paper | Scissors</title>
    <link rel="stylesheet" href="style.css">
    <script src="script.js"></script>
</head>
<body onload="loadGame()">
    <div class="container">
        <div class="left">
            <span id="op-1" class="option">&#9994;</span>
            <span id="op-2" class="option">&#9995;</span>
            <span id="op-3" class="option">&#9996;</span>
        </div>
        <div class="right">
            <span id="op-4" class="option">&#9994;</span>
            <span id="op-5" class="option">&#9995;</span>
            <span id="op-6" class="option">&#9996;</span>
        </div>
    </div>
    <div class="bottom">
        <button onclick="play()">Start</button>
    </div>
</body>
</html>
