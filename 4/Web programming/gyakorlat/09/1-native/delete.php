<?php

$data = json_decode(file_get_contents(__DIR__ . "/../data.json"), true);
$id = $_GET['id'] ?? -1;
if (isset($data[$id])) {
    unset($data[$id]);
    file_put_contents(__DIR__ . "/../data.json", json_encode($data, JSON_PRETTY_PRINT));
}
header("location: index.php");
