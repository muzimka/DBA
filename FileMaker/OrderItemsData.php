<?php

/**
 * Created by PhpStorm.
 * User: MainW8
 * Date: 5/4/2017
 * Time: 11:27 PM
 */
class OrderItemsData extends DataGenerator
{
    public function __construct($maxRecords, $dbVersion = 3, $isMysql = false, $isNewFile = false)
    {
        $this->file_name_pg = 'order_items_data';
        $this->file_name_mysql = 'order_items';
        if(empty($isMysql)){
            $this->headerCSV = 'fk_order,fk_product,quantity'."\n";
        }
        parent::__construct(10000, $dbVersion, $isMysql, $isNewFile);
    }


    protected function prepareNextRecord()
    {
        $record =
            $this->getFkOrder().
            $this->getFkProduct().
            $this->getQuantity();
        return $record;
    }

    private function getFkOrder(){
        $res = $this->recordCount.self::COLUMN_DELIMETR;
        $this->recordCount++;
        return $res;
    }

    private function getFkProduct(){
        return rand(1,1000000).self::COLUMN_DELIMETR;
    }

    private function getQuantity(){
        return rand(1,10);
    }

}