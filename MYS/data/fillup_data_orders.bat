@ECHO OFF
SET SERVER=localhost
SET USERNAME=root
SET DATABASE=lesson3
SET TABLE=orders
SET FILE_NAME=.\orders_10000_v3.csv
SET NEW_FILE_NAME=.\%TABLE%.csv


copy %FILE_NAME% %NEW_FILE_NAME%

echo You are going to add 10000 records to MYSql server to table %TABLE%
mysqlimport -h %SERVER% -u %USERNAME% -p --delete -c "number,dt" --local --lines-terminated-by="\n" --fields-terminated-by="," %DATABASE% %NEW_FILE_NAME%

pause