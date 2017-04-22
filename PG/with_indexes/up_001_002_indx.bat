@ECHO OFF
SET SERVER=localhost
SET USERNAME=dba3
SET DATABASE=lesson3
SET FILE_NAME=.\ddl\up_001_002.sql
SET PORT=5432
ECHO --Migration up from 1 to version 2--
psql.exe  --file=%file_name% -h %server% -U %username% -d %database% -p %port% -A
pause

