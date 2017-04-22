BEGIN;
CREATE TABLE IF NOT EXISTS product_type (
  id    SMALLSERIAL PRIMARY KEY UNIQUE NOT NULL,
  label CHAR(50)                       NOT NULL
);

CREATE TABLE product_brand (
  id    SMALLSERIAL PRIMARY KEY UNIQUE NOT NULL,
  label CHAR(50)                       NOT NULL
);

ALTER TABLE product_items
  ADD COLUMN
  type_id INTEGER NULL;

ALTER TABLE product_items
  ADD COLUMN brand_id INTEGER NULL;

ALTER TABLE product_items
  ADD FOREIGN KEY (type_id) REFERENCES product_type (id)
ON UPDATE CASCADE
ON DELETE SET NULL;

ALTER TABLE product_items
  ADD FOREIGN KEY (brand_id) REFERENCES product_brand (id)
ON UPDATE CASCADE
ON DELETE SET NULL;

INSERT INTO db_version (version) VALUES ( 003 );

COMMIT;