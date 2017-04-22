SET SERVER=localhost
SET USERNAME=root
SET DATABASE=lesson3
SET FILE_NAME=.\ddl\down_001_000.sql
ECHO --Migration down from 1 to version 0--
mysql -h %SERVER% -u %USERNAME% -p -D %DATABASE% < %FILE_NAME%
pause