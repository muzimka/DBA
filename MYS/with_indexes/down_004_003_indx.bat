@ECHO OFF
SET SERVER=localhost
SET USERNAME=root
SET DATABASE=lesson3

SET FILE_NAME=.\ddl\down_004_003.sql
ECHO --Migration down from 4 to version 3--
pause
mysql.exe -h %SERVER% -u %USERNAME% -p -D %DATABASE% < %FILE_NAME%
pause