<?php

include_once __DIR__ . '/DataGenerator.php';
include_once __DIR__ . '/ProductData.php';
include_once __DIR__ . '/OrderData.php';
include_once __DIR__ . '/OrderItemsData.php';

$a = new ProductData(1000000,3,true,true);
$a->makeFileWithRecordsOf();




echo 'OK';