
START TRANSACTION;
INSERT INTO db_version (version) VALUES ( 003 );

ALTER TABLE product_brand
  DROP COLUMN
  fid_class;

DROP TABLE class_brand;



COMMIT TRANSACTION;
