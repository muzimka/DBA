@ECHO OFF
SET SERVER=localhost
SET USERNAME=root
SET DATABASE=lesson3
SET TABLE=product_brand
SET FILE_NAME=.\product_brand.csv


echo You are going to add records to MYSql server to table %TABLe% & pause


mysqlimport -h %SERVER% -u %USERNAME% -p --delete -c "id,label,fid_class" --local  --lines-terminated-by="\n" --fields-terminated-by="," %DATABASE% %FILE_NAME%
pause