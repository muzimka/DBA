@ECHO OFF
SET SERVER=localhost
SET USERNAME=root
SET DATABASE=lesson3
SET TABLE=class_brand
SET FILE_NAME=.\class_brand.csv


echo You are going to add records to MYSql server to table %TABLe% & pause


mysqlimport -h %SERVER% -u %USERNAME% -p --delete -c "id,label" --local  --lines-terminated-by="\n" --fields-terminated-by="," %DATABASE% %FILE_NAME%
pause

