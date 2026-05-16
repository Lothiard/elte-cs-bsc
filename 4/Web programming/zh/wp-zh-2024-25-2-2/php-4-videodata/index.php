<?php

include_once(__DIR__ . "/../data/data_array_of_arrays.php");
usort($data, function ($a, $b) {
    return strcmp($a['title'], $b['title']);
});
?>

<!DOCTYPE html>
<html lang="hu">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>4. feladat</title>
    <link rel="stylesheet" href="index.css" />
</head>

<body>
    <h1>4. Videók</h1>
    <div id="main">
        <?php foreach ($data as $d):
            if ($d['views'] >= 100) {
                $popularity = "very-popular";
            } elseif ($d['views'] >= 10) {
                $popularity = "partially-popular";
            } else {
                $popularity = "slightly-popular";
            }
            ?>

            <a class="card <?= $popularity ?>" href="https://www.youtube.com/watch?v=<?= $d['yt'] ?>" target="_blank">
                <img src="img/<?= $d['id'] ?>.jpg">
                <h2><?= $d['title'] ?></h2>
                <span class="year"><?= $d['year'] ?></span>
                <span class="views"><?= $d['views'] ?> millió</span>
            </a>
        <?php endforeach; ?>
    </div>
</body>

</html>
