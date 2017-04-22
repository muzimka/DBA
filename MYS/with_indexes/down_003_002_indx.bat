SET SERVER=localhost
SET USERNAME=root
SET DATABASE=lesson3

SET FILE_NAME=.\ddl\down_003_002.sql
ECHO --Migration down from 3 to version 2--
pause
mysql.exe -h %SERVER% -u %USERNAME% -p -D %DATABASE% < %FILE_NAME%
pause