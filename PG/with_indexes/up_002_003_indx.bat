@ECHO OFF
SET SERVER=localhost
SET USERNAME=dba3
SET DATABASE=lesson3
SET FILE_NAME=.\ddl\up_002_003.sql
SET PORT=5432
ECHO --Migration up to from 2 to version 3--
psql.exe  --file=%file_name% -h %server% -U %username% -d %database% -p %port% -A
pause

