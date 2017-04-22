/*profiling*/

SET PROFILING = 1;
SET PROFILING = 0;
SHOW PROFILES;

SHOW PROFILE FOR QUERY 231;

/*profile info*/
SELECT
  STATE,
  FORMAT( DURATION, 6 ) AS DURATION
FROM INFORMATION_SCHEMA.PROFILING
WHERE QUERY_ID = 300
ORDER BY SEQ;

/*db version*/
SELECT
  date,
  version
FROM db_version
ORDER BY date DESC
LIMIT 1;



/*All*/
use lesson3;
SELECT * FROM product_items;
SELECT * from product_brand;
SELECT * from product_type;

DELETE from product_items;
DELETE FROM product_type;
DELETE FROM product_brand;