<?php

$name = trim($_POST["name"] ?? "");
$cats = $_POST["cats"] ?? "";
$size = $_POST["size"] ?? "";
$card = trim($_POST["card"] ?? "");
$accept = $_POST["accept"] ?? "";

$errors = [];

if ($_POST) {
    if ($name === "") {
        $errors["name"] = "A nevet ki kell tölteni!";
    } elseif (count(explode(" ", $name)) < 2) {
        $errors["name"] = "A név két szóból álljon legalább!";
    }

    if ($cats === "") {
        $errors["cats"] = "A macskák számát ki kell tölteni!";
    } elseif (filter_var($cats, FILTER_VALIDATE_INT) === false) {
        $errors["cats"] = "A macskák száma egész szám lehet csak!";
    } elseif ($cats < 0) {
        $errors["cats"] = "A macskák száma nem lehet negatív!";
    }

    if (!in_array($size, ["s", "m", "l", "xl", "xxl"])) {
        $errors["size"] = "Érvénytelen méret!";
    }

    if (!preg_match('/^\d{4}-\d{4}-\d{4}-\d{4}$/', $card)) {
        $errors["card"] = "Érvénytelen kártyaszám!";
    }

    if ($accept !== "on") {
        $errors["accept"] = "Be kéne pipálni!";
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <form action="2.php" method="POST" novalidate>
        Teljes név: <input type="text" name="name" value="<?= $name ?>"> <?= $errors["name"] ?? "" ?><br>
        <!-- 1.) ki van töltve !== "", 2.) legalább két szó -->

        Macskák száma: <input type="number" name="cats" value="<?= $cats ?>"> <?= $errors["cats"] ?? "" ?> <br>
        <!-- 1.) ki van töltve 2.) egész szám 3.) nem-negatív -->

        Póló méret: <select name="size">
            <option value="s" <?= $size === "s" ? "selected" : "" ?> >S</option>
            <option value="m" <?= $size === "m" ? "selected" : "" ?> >M</option>
            <option value="l" <?= $size === "l" ? "selected" : "" ?> >L</option>
            <option value="xl" <?= $size === "xl" ? "selected" : "" ?> >XL</option>
            <option value="xxl" <?= $size === "xxl" ? "selected" : "" ?> >XXL</option>
        </select> <?= $errors["size"] ?? "" ?> <br>
        <!-- a megadott értéke egyike van kiválasztva -->

        Bankkártyaszám: <input type="text" name="card" value="<?= $card ?>"> <?= $errors["card"] ?? "" ?> <br>
        <!-- pontosan NNNN-NNNN-NNNN-NNNN formátumá, ahol N számjegy -->

        <input type="checkbox" name="accept" <?= $accept === "on" ? "checked" : "" ?>> Elfogadom a feltételeket
        <?= $errors["accept"] ?? "" ?> 
        <!-- muszáj bepipálni -->

        <br>
        <button type="submit">Mentés</button>
    </form>
</body>
</html>
