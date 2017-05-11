@ECHO OFF

SET USER=dba3
SET HOST=localhost
SET DATABASE=lesson3
SET TABLE=product_brand
SET FILE_NAME=.\product_brand.csv


echo You are going to add records to PGSql server to table %TABLe%


psql -h %HOST% -U %USER% -d %DATABASE% -c "copy %TABLE%(id,label,fid_class) from stdin with encoding 'utf8' delimiter ',' NULL 'NULL'" < %FILE_NAME%
pause