@ECHO OFF
SET DATABASE=lesson3
SET TABLE=product_items
SET USER=dba3
SET HOST=localhost
SET FILE_NAME=.\prod_items_data_1000000.csv

echo You are going to add 1000000 records to PGSql server to %DATABASE%.%TABLE% & pause


psql -h %HOST% -U %USER% -d %DATABASE% -c "copy %TABLE%(article, title, price,prev_price, record_date, quantity) from stdin with encoding 'utf8' delimiter ',' NULL 'NULL'" < %FILE_NAME%
pause