@ECHO OFF
SET SERVER=localhost
SET USERNAME=root
SET DATABASE=lesson3
SET FILE_NAME=.\ddl\up_004_005.sql
ECHO --Migration up from 4 to version 5--
mysql.exe -h %SERVER% -u %USERNAME% -p -D %DATABASE% < %FILE_NAME%
pause
