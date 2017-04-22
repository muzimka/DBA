@ECHO OFF
SET SERVER=localhost
SET USERNAME=root
SET DATABASE=lesson3.product_items
SET FILE_NAME=.\product_items_1000_v3.csv
SET NEW_FILE_NAME=.\product_items.csv


copy %FILE_NAME% %NEW_FILE_NAME%

echo You are going to add 1000 records to MYSql server to table %DATABASE% 
mysqlimport -h %SERVER% -u %USERNAME% -p --delete -c "article,title,price,prev_price,record_date,quantity,type_id,brand_id" --local --lines-terminated-by="\n" --fields-terminated-by="," lesson3 %NEW_FILE_NAME% 

pause