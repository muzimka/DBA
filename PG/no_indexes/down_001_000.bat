SET SERVER=localhost
SET USERNAME=dba3
SET DATABASE=lesson3
SET FILE_NAME=down_001_000.sql
SET PORT=5432

ECHO --Migration down from version 1 to 0 --
PAUSE
psql.exe  --file=%file_name% -h %server% -U %username% -d %database% -p %port% -A
PAUSE
