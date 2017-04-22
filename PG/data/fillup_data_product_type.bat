@ECHO OFF
SET DATABASE=lesson3
SET TABLE=product_type
SET USER=dba3
SET HOST=localhost
SET FILE_NAME=.\product_type.csv


echo You are going to add records to PGSql server to table %TABLe%


psql -h %HOST% -U %USER% -d %DATABASE% -c "copy %TABLE%(id,label) from stdin with encoding 'utf8' delimiter ',' NULL 'NULL'" < %FILE_NAME%
pause