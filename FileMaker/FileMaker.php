<?php

class FileMaker
{
    private $max;
    private $recordCount = 1;
    private $articleOffset = 2;
    private $titleLength = 100;
    private $minPrice = 10;
    private $maxPrice = 20000;
    private $maxDiscount = 0.5;
    private $currentDate;
    private $maxQuantity = 100;
    const COLUMN_DELIMETR = ',';
    private $file_name_pg = 'prod_items_data';
    private $file_name_mysql = 'product_items';
    const FILE_EXTENSION = '.csv';
    private $isMYSQL;
    private $isNewFile;
    const NULL_MARKER = 'NULL';
    private $dbVersion;
    const MAX_BRAND_ID = 8;
    const MAX_TYPE_ID = 7;
    const ASSOC_BRAND_TYPE = [
        [1, 4], // товары для дома
        [5, 8], //еда
        [9, 11],//посуда
        [12, 14],// обувь
        [15, 17], //игрушки
        [18, 20], //канцтовара
        [21, 23],//книги
    ];


    /**
     * FileMaker constructor.
     */
    public function __construct($recordCount, $dbVersion = 1, $isMysql = false, $isNewFile = false)
    {
        $this->dbVersion = $dbVersion;
        $this->isNewFile = $isNewFile;
        $this->max = $recordCount;
        $this->isMYSQL = $isMysql;
        $timezone = new DateTimeZone('Europe/Moscow');
        $this->currentDate = new DateTime('now', $timezone);
        $this->file_name_pg .= '_' . $recordCount . self::FILE_EXTENSION;
        $this->file_name_mysql .= '_' . $recordCount . self::FILE_EXTENSION;
    }

    public function makeFileWithRecordsOf()
    {
        $this->generateFileName();
        $file = $this->getAndPrepareFileResource();

        for ($i = 0; $i < $this->max; $i++) {
            $nextRecord = sprintf("%s\n", $this->prepareNextRecord());
            fputs($file, $nextRecord);
        }
        fclose($file);
    }

    private function prepareNextRecord()
    {
        $priceStr = $this->getRandomPrice();
        $priceInt = (int)$priceStr;
        $record = '';

        $record =
            $this->getNextArticle() .
            $this->getRandomTitle() .
            $priceStr .
            $this->getPreviousPrice($priceInt) .
            $this->getRandomDate() .
            $this->getRandomQuantity();

        if ($this->dbVersion == 3) {
            $record .= $this->getTypeAndBrand();
        }
        return $record;
    }

    private function getTypeAndBrand()
    {
        $typeArrSize = sizeof(self::ASSOC_BRAND_TYPE);
        $typeRaw = rand(0, $typeArrSize - 1);

        $brand = rand(
            self::ASSOC_BRAND_TYPE[$typeRaw][0],
            self::ASSOC_BRAND_TYPE[$typeRaw][1]
        );

        $type = ++$typeRaw;
        $res = self::COLUMN_DELIMETR.$type . self::COLUMN_DELIMETR . $brand;
        return $res;
    }

    private function getNextArticle()
    {
        if ($this->recordCount > $this->max) {
            return;
        }
        $article = '';
        $rand = $this->getRandomBool();
        if ($rand != 0) {
            $article .= 'TEST';
        }
        $article .= $this->recordCount + $this->articleOffset;
        $this->recordCount++;
        return $article.self::COLUMN_DELIMETR;
    }

    private function getRandomBool()
    {
        $a = rand(1, 12234567);
        return ($a % 2 == 0) ? 0 : 1;
    }

    private function getRandomTitle()
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

    private function getRandomPrice()
    {
        return rand($this->minPrice, $this->maxPrice) . self::COLUMN_DELIMETR;
    }


    private function getPreviousPrice($currPrice)
    {
        if (($disc = $this->getRandomDiscount($currPrice)) != 0) {
            $prevPrice = $currPrice + $disc;

            if ($prevPrice > $this->maxPrice) {
                $prevPrice = $this->maxPrice;
            }
            return $prevPrice . self::COLUMN_DELIMETR;
        }
        return self::NULL_MARKER . self::COLUMN_DELIMETR;
    }

    private function getRandomDiscount($currPrice)
    {
        $b = $this->getRandomBool();
        $disc = -1;
        if ($b == 0) {
            $disc = rand(0, $currPrice * $this->maxDiscount);
            return $disc;
        }
        return 0;

    }

    private function getRandomDate()
    {
        $date = clone ($this->currentDate);
        $r = rand(1, 365);
        $interval = new DateInterval('P' . $r . 'D');
        $operation = $this->getRandomBool();
        if ($operation == 0) {
            date_sub($date, $interval);
        } else {
            $date = date_add($date, $interval);
        }
        return $date->format('Y-m-d') . self::COLUMN_DELIMETR;
    }

    private function getRandomQuantity()
    {
        return rand(1, $this->maxQuantity);
    }

    private function generateFileName()
    {
        if ($this->dbVersion == 3 && $this->isMYSQL == true) {
            $this->file_name_mysql = str_replace(self::FILE_EXTENSION, '_v3', $this->file_name_mysql) . self::FILE_EXTENSION;
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
    }
}




