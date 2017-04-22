SET SERVER=localhost
SET USERNAME=root
SET DATABASE=lesson3
SET FILE_NAME=down_001_000.sql
ECHO --Migration up to version 1--
pause
mysql -h %SERVER% -u %USERNAME% -p -D %DATABASE% < %FILE_NAME%
pause
