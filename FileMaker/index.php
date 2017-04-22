<?php

include_once __DIR__.'/FileMaker.php';

$a = new FileMaker(1000,3,true,true);
$a->makeFileWithRecordsOf();
echo 'OK';