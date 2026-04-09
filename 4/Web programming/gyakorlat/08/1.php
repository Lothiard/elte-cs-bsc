<?php
$a = $_GET["a"] ?? 0;
$b = $_GET["b"] ?? 0;

$errors = [];

if ($_GET) {
    if (filter_var($a, FILTER_VALIDATE_FLOAT) === false) {
        $errors["a"] = "A értéke legyen szám!";
    }

    if (filter_var($b, FILTER_VALIDATE_FLOAT) === false) {
        $errors["b"] = "B értéke legyen szám!";
    }

    if (count($errors) === 0) {
        $x = $a + $b;
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
    <form action="1.php" method="GET">
        A = <input type="number" name="a" value="<?= $a ?>">
        <?= $errors["a"] ?? "" ?>

        <br>
        B = <input type="number" name="b" value="<?= $b ?>">
        <?= $errors["b"] ?? "" ?>

        <br>

        <button type="submit">Add össze őket!</button>
    </form>

    <?php if (isset($x)) : ?>
        Eredmény: <?= $x ?>
    <?php endif; ?>
</body>
</html>
