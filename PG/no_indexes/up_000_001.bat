SET SERVER=localhost
SET USERNAME=dba3
SET DATABASE=lesson3
SET FILE_NAME=up_000_001.sql
SET PORT=5432
ECHO --Migration up to version 1--
pause
psql.exe  --file=%file_name% -h %server% -U %username% -d %database% -p %port% -A
pause

