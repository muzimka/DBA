START TRANSACTION;

CREATE TABLE class_brand (
  id    SMALLSERIAL NOT NULL PRIMARY KEY,
  label CHAR(3)
);

ALTER TABLE product_brand
  ADD COLUMN
  fid_class INTEGER NULL;


INSERT INTO db_version (version) VALUES ( 004 );

COMMIT TRANSACTION;
