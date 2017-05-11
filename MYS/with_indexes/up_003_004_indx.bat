@ECHO OFF
SET SERVER=localhost
SET USERNAME=root
SET DATABASE=lesson3
SET FILE_NAME=.\ddl\up_003_004.sql
ECHO --Migration up from 3 to version 4--
mysql.exe -h %SERVER% -u %USERNAME% -p -D %DATABASE% < %FILE_NAME%
pause
