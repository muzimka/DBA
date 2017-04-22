BEGIN ;

ALTER TABLE product_items DROP FOREIGN KEY product_items_ibfk_1;
ALTER TABLE product_items DROP FOREIGN KEY product_items_ibfk_2;
ALTER TABLE product_items DROP COLUMN brand_id;
ALTER TABLE product_items DROP COLUMN type_id;

DROP TABLE product_brand;
DROP TABLE product_type;

INSERT INTO db_version (version) VALUES ( 002 );

COMMIT ;