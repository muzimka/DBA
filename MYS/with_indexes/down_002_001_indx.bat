SET SERVER=localhost
SET USERNAME=root
SET DATABASE=lesson3
SET FILE_NAME=.\ddl\down_002_001.sql
ECHO --Migration down from 2 to version 1--pause
mysql -h %SERVER% -u %USERNAME% -p -D %DATABASE% < %FILE_NAME%
pause