@ECHO OFF
SET SERVER=localhost
SET USERNAME=root
SET DATABASE=lesson3
SET TABLE=product_items
SET FILE_NAME=.\product_items_1000000_v3.csv
SET NEW_FILE_NAME=.\%TABLE%.csv

echo You are going to add 1000000 records to MYSql server to table %TABLE% & pause
copy %FILE_NAME% %NEW_FILE_NAME%
mysqlimport -h %SERVER% -u %USERNAME% -p --delete --local --columns="article, title, price,prev_price, record_date,quantity,type_id, brand_id" --lines-terminated-by="\n" --fields-enclosed-by="\"" --fields-terminated-by=","  %DATABASE% %NEW_FILE_NAME%
pause