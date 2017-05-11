<?php


class ProductData extends DataGenerator
{

    private $articleOffset = 2;

    private $minPrice = 10;
    private $maxPrice = 20000;
    private $maxDiscount = 0.5;
    private $maxQuantity = 100;
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

    public function __construct($maxRecords, $dbVersion = 3, $isMysql = false, $isNewFile = false)
    {
        $this->file_name_pg = 'prod_items_data';
        $this->file_name_mysql = 'product_items';
        parent::__construct($maxRecords, $dbVersion, $isMysql, $isNewFile);

    }

    protected function prepareNextRecord()
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
        $brand = 'NULL';
        $type = 'NULL';
        if ($this->getRandomBool() == true) {
            $brand = rand(
                self::ASSOC_BRAND_TYPE[$typeRaw][0],
                self::ASSOC_BRAND_TYPE[$typeRaw][1]
            );
        }

        if (true == $this->getRandomBool()) {
            $type = ++$typeRaw;
        }
        $res = self::COLUMN_DELIMETR . $type . self::COLUMN_DELIMETR . $brand;
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
        return $article . self::COLUMN_DELIMETR;
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

    private function getRandomQuantity()
    {
        return rand(0, $this->maxQuantity);
    }

}