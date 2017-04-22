@ECHO OFF
SET SERVER=localhost
SET USERNAME=root
SET DATABASE=lesson3.product_items
SET FILE_NAME=.\product_items_1000000.csv
SET NEW_FILE_NAME=.\product_items.csv

echo You are going to add 1000000 records to MYSql server to table %DATABASE% & pause
copy %FILE_NAME% %NEW_FILE_NAME%
mysqlimport -h %SERVER% -u %USERNAME% -p --delete --local --columns="article,title,price,prev_price,record_date,quantity" --lines-terminated-by="\n" --fields-terminated-by="," lesson3 %NEW_FILE_NAME%
pause