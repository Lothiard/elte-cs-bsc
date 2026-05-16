<?php

include_once(__DIR__ . "/../data_array_of_arrays.php");

$errors = [];
$success = false;

$title = $_POST["title"] ?? "";
$year = $_POST["year"] ?? "";
$views = $_POST["views"] ?? "";
$manualid = $_POST["manualid"] ?? "";
$id = $_POST["id"] ?? "";
if ($_POST) {
    if ($title === "") {
        $errors[] = "A cim megadasa kotelezo";
    } elseif (mb_strlen($title) < 5) {
        $errors[] = "A cim legalabb 5 karakter hosszu kell legyen";
    } elseif (!str_contains($title, " - ")) {
        $errors[] = "A cimben szerepelnie kell a \" - \" karaktersorozatnak";
    }

    if ($year === "") {
        $errors[] = "Az ev megadasa kotelezo";
    } elseif (filter_var($year, FILTER_VALIDATE_INT) === false) {
        $errors[] = "Az ev egesz szam legyen";
    }

    if ($views === "") {
        $errors[] = "A nezettseg megadasa kotelezo";
    } elseif (filter_var($views, FILTER_VALIDATE_FLOAT) === false) {
        $errors[] = "A nezettseg szam legyen";
    } elseif ($views < 0.01) {
        $errors[] = "A nezettseg nem lehet kisebb mint 0.01 millio";
    }

    if ($manualid === "") {
        $errors[] = "A kezi ID megadasa kotelezo";
    }
    if ($manualid === yes && $id === "") {
        $errors[] = "A cim megadasa kotelezo";
    }

    if (!$errors) {
        $success = true;
    }
}
?>

<!DOCTYPE html>
<html lang="hu">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>5. feladat</title>
    <link rel="stylesheet" href="index.css" />
</head>

<body>
    <h1>5. Új zeneszám</h1>
    <div id="main">
        <form action="index.php" method="post">
            <label>
                Cím
                <input name="title">
            </label>
            <label>
                Megjelenés éve
                <input name="year">
            </label>
            <label>
                Nézettség
                <input name="views">
            </label>
            <div>
                Kézi ID
                <label><input type="radio" name="manualid" value="yes"> Igen</label>
                <label><input type="radio" name="manualid" value="no"> Nem</label>
            </div>
            <label>
                ID
                <input name="id">
            </label>
            <input type="submit">
        </form>

        <?php if ($success): ?>
            <div id="success">Új zeneszám hozzáadva!</div>
        <?php endif ?>

        <?php if ($errors): ?>
            <div id="errors">
                Hiba!
                <ul>
                    <?php foreach ($errors as $error): ?>
                        <li><?= $error ?></li>
                    <?php endforeach; ?>
                </ul>
            </div>
        <?php endif; ?>
    </div>
</body>

</html>
