
BEGIN ;


ALTER TABLE product_items DROP COLUMN IF EXISTS brand_id;
ALTER TABLE product_items DROP COLUMN IF EXISTS type_id;

DROP TABLE if EXISTS product_brand;
DROP TABLE IF EXISTS product_type;

INSERT INTO db_version (version) VALUES ( 002 );

COMMIT ;