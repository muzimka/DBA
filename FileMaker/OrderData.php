<?php


class OrderData extends DataGenerator
{

    private $maxOrderNumber = 10000000;

    /**
     * OrderData constructor.
     */
    public function __construct($maxRecords, $dbVersion = 3, $isMysql = false, $isNewFile = false)
    {
        $this->file_name_pg = 'orders_data';
        $this->file_name_mysql = 'orders';
        parent::__construct(10000, $dbVersion, $isMysql, $isNewFile);
    }

    protected function prepareNextRecord()
    {
        $record = $this->generateOrderNumber();
        if($this->isMYSQL){
            $record .= $this->getRandomTimeStamp();
        }else{
            $record .= $this->getRandomTime(true).
            $this->getRandomDate();
        }

        $record = substr_replace($record,'',strlen($record)-1);
        return $record;
    }

    private function generateOrderNumber(){
        return rand(1,$this->maxOrderNumber). parent::COLUMN_DELIMETR;
    }

}