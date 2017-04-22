@ECHO OFF
SET SERVER=localhost
SET USERNAME=root
SET DATABASE=lesson3
SET TABLE=product_type
SET FILE_NAME=.\product_type.csv


echo You are going to add records to MYSql server to table %TABLe% & pause


mysqlimport -h %SERVER% -u %USERNAME% -p --delete -c "id,label" --local --lines-terminated-by="\n" --fields-terminated-by="," %DATABASE% %FILE_NAME%
pause