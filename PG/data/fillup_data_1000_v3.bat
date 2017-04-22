@ECHO OFF
SET DATABASE=lesson3
SET TABLE=product_items
SET USER=dba3
SET HOST=localhost
SET FILE_NAME=.\prod_items_data_1000_v3.csv

echo You are going to add 1000 records to PGSql server to %DATABASE%.%TABLE% 

psql -h %HOST% -U %USER% -d %DATABASE% -c "copy %TABLE%(article, title, price,prev_price, record_date, quantity,type_id,brand_id) from stdin with encoding 'utf8' delimiter ',' NULL 'NULL'" < %FILE_NAME%
pause