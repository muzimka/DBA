@ECHO OFF
SET SERVER=localhost
SET USERNAME=root
SET DATABASE=lesson3

SET FILE_NAME=.\ddl\down_005_004.sql
ECHO --Migration down from 5 to version 4--
pause
mysql.exe -h %SERVER% -u %USERNAME% -p -D %DATABASE% < %FILE_NAME%
pause