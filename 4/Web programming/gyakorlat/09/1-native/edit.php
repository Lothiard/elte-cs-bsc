<?php

$data = json_decode(file_get_contents("data.json"), true);
$id = $_GET['id'] ?? - 1;
if (!isset($data[$id])) {
    header("location: index.php");
}

$name = $_POST["name"] ?? "";
$age = $_POST["age"] ?? "";
if ($_POST) {
    $data[$id] = [
        "id" => $id,
        "name" => $name,
        "age" => intval($age)
    ];
    file_put_contents(__DIR__ . "/../data.json", json_encode($data, JSON_PRETTY_PRINT));
    header("location: index.php");
}
?>

<!doctype html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Document</title>
    </head>
    <body>
        <form action="edit.php?id=<?= $id ?>" method="POST">
            Név: <input type="text" name="name" value="<?= $data[$id]["name"] ?>"> <br>
            Kor: <input type="number" name="age" value="<?= $data[$id]["age"] ?>"> <br>
            <button type="submit">Mentés</button>
        </form>
    </body>
</html>
