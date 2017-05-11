<?php

abstract class DataGenerator
{
    protected $max;
    protected $recordCount = 1;
    protected $currentDate;
    protected $isMYSQL;
    protected $file_name_pg;
    protected $file_name_mysql;
    protected $isNewFile;
    protected $dbVersion;
    protected $titleLength = 100;
    protected $headerCSV = null;

    const COLUMN_DELIMETR = ',';
    const NULL_MARKER = 'NULL';
    const FILE_EXTENSION = '.csv';



    /**
     * FileMaker constructor.
     */
    public function __construct($maxRecords, $dbVersion = 3, $isMysql = false, $isNewFile = false)
    {
        $this->dbVersion = $dbVersion;
        $this->isNewFile = $isNewFile;
        $this->max = $maxRecords;
        $this->isMYSQL = $isMysql;
        $timezone = new DateTimeZone('Europe/Moscow');
        $this->currentDate = new DateTime('now', $timezone);
        $this->file_name_pg .= '_' . $maxRecords . self::FILE_EXTENSION;
        $this->file_name_mysql .= '_' . $maxRecords . self::FILE_EXTENSION;
    }



    protected abstract function prepareNextRecord();

    public function makeFileWithRecordsOf()
    {
        $this->generateFileName();
        $file = $this->getAndPrepareFileResource();
        if(!is_null($this->headerCSV)){
            fputs($file, $this->headerCSV);
        }

        for ($i = 0; $i < $this->max; $i++) {
            $nextRecord = sprintf("%s\n", $this->prepareNextRecord());
            fputs($file, $nextRecord);
        }
        fclose($file);
    }

    protected function getRandomBool()
    {
        $a = rand(1, 12234567);
        return ($a % 2 == 0) ? 0 : 1;
    }

    protected function getRandomTitle()
    {
        $title = '';
        for ($i = 0; $i < $this->titleLength; $i++) {
            $r = (int)rand(1040, 1103);
            $r = '\u0' . dechex($r);
            $unicodeChar = $r;
            $unicodeChar = json_decode('"' . $unicodeChar . '"');
            $title .= $unicodeChar;
        }
        return $title . self::COLUMN_DELIMETR;
    }


    protected function getRandomDate()
    {
        $date = $this->createRandomDateTime();
        return $date->format('Y-m-d') . self::COLUMN_DELIMETR;
    }

    protected function getRandomTime($isTimeZone=false){
        $raw = $this->createRandomDateTime(true);
        $time = $raw->format('H:i:s');
        if($isTimeZone){
            $time .= '+03';
        }
        return $time.self::COLUMN_DELIMETR;

    }



    protected function getRandomTimeStamp(){
        $date = $this->getRandomDate();
        $date = substr_replace($date,'',strlen($date)-1);
        $date .= ' '.$this->getRandomTime();
        return $date;
    }


    private function generateFileName()
    {
        if ($this->dbVersion == 3 && $this->isMYSQL == true) {
            $this->file_name_mysql = str_replace(self::FILE_EXTENSION, '_v3', $this->file_name_mysql) . self::FILE_EXTENSION;
        } else if ($this->dbVersion == 3 && $this->isMYSQL == false) {
            $this->file_name_pg = str_replace(self::FILE_EXTENSION, '_v3', $this->file_name_pg) . self::FILE_EXTENSION;
        }
    }

    private function getAndPrepareFileResource()
    {
        if (true == $this->isNewFile && file_exists($this->file_name_mysql) && true == $this->isMYSQL) {
            unlink($this->file_name_mysql);
        }
        if (true == $this->isNewFile && file_exists($this->file_name_pg) && false == $this->isMYSQL) {
            unlink($this->file_name_pg);
        }
        if (true == $this->isMYSQL) {
            $file = fopen($this->file_name_mysql, 'a');
            return $file;
        } else {
            $file = fopen($this->file_name_pg, 'a');
            return $file;
        }
    }/**
 * @return DateTime|false
 */private function createRandomDateTime($isTime=false)
{
    $date = clone ($this->currentDate);
    $interval = $this->createRandomDTInterval($isTime);
    $operation = $this->getRandomBool();
    if ($operation == 0) {
        date_sub($date, $interval);
        return $date;
    } else {
        $date = date_add($date, $interval);
        return $date;
    }
}

    /**
     * @param $isTime
     * @return DateInterval
     */
    private function createRandomDTInterval($isTime)
    {
        $d = rand(1, 365);
        $h = rand(0, 24);
        $m = rand(0, 59);
        $s = rand(0, 59);
        $intervalStr = null;
        if ($isTime) {
            $intervalStr = "PT{$h}H{$m}M{$s}S";

        } else {
            $intervalStr = "P{$d}D";
        }
        $interval = new DateInterval($intervalStr);
        return $interval;
    }
}




