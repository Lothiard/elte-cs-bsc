<?php

include_once("Storage.php");
$stor = new Storage(new JsonIO(__DIR__ . "/../data.json"));
$id = $_GET['id'] ?? -1;
$stor -> delete($id);
header("location: index.php");
