<?php

include_once("Storgae.json");
$stor = new Storage(new JsonIO(__DIR__ . "/../data.json"));
$id = $_GET['id'] ?? - 1;
$d = $stor -> findById($id);

if ($d === null) {
    header("location: index.php");
}

$name = $_POST["name"] ?? "";
$age = $_POST["age"] ?? "";
if ($_POST) {
    $stor -> update($id, [
        "id" => $id,
        "name" => $name,
        "age" => intval($age)
    ]);
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
            Név: <input type="text" name="name" value="<?= $d["name"] ?>"> <br>
            Kor: <input type="number" name="age" value="<?= $d["age"] ?>"> <br>
            <button type="submit">Mentés</button>
        </form>
    </body>
</html>
