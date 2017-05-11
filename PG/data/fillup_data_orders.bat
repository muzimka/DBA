@ECHO OFF
SET DATABASE=lesson3
SET TABLE=orders
SET USER=dba3
SET HOST=localhost
SET FILE_NAME=.\orders_data_1000_v3.csv


echo You are going to add records to PGSql server to table %TABLe%


psql -h %HOST% -U %USER% -d %DATABASE% -c "copy %TABLE%(number,time,date) from stdin with encoding 'utf8' delimiter ',' NULL 'NULL'" < %FILE_NAME%
pause