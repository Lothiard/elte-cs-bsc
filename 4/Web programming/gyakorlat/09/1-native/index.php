<?php
$data = json_decode(file_get_contents(__DIR__ . "/../data.json"), true);
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <h1>Listázó oldal</h1>
    <?php foreach ($data as $d) : ?>
        <?= $d["id"] ?>:
        <a href="show.php?id=<?= $d["id"] ?>">
            <?= $d["name"] ?>
        </a><br>
    <?php endforeach; ?>
</body>
</html>
