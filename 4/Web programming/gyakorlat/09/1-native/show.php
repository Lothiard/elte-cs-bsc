<?php

$data = json_decode(file_get_contents(__DIR__ . "/../data.json"), true);
$id = $_GET['id'] ?? -1;
if (!isset($data[$id])) {
    // elküldöm őt a fenébe :)
    header("location: index.php");
}
$d = $data[$id];
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    ID: <?= $d["id"] ?> <br>
    Név: <?= $d["name"] ?> <br>
    Kor: <?= $d["age"] ?> <br>

    <a href="edit.php?id=<?= $d["id"] ?>">Szerkesztés</a> <br>
    <a href="delete.php?id=<?= $d["id"] ?>">Törlés</a> <br>

    <br>
    <a href="index.php">Vissza</a>
</body>
</html>
