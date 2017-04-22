@ECHO OFF
SET SERVER=localhost
SET USERNAME=dba3
SET DATABASE=lesson3
SET FILE_NAME=.\ddl\down_002_001.sql
SET PORT=5432

ECHO --Migration down from 2 to version 1 --
psql.exe  --file=%file_name% -h %server% -U %username% -d %database% -p %port% -A
PAUSE
