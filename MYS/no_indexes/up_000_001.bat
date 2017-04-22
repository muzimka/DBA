SET SERVER=localhost
SET USERNAME=root
SET DATABASE=lesson3
SET FILE_NAME=.\ddl\up_000_001.sql
ECHO --Migration up to version 1--
pause
mysql.exe -h %SERVER% -u %USERNAME% -p -D %DATABASE% < %FILE_NAME%
pause

