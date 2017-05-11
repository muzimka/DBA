START TRANSACTION;

CREATE TABLE order_items (
  fk_order   INTEGER NOT NULL DEFAULT 0,
  fk_product INTEGER NOT NULL DEFAULT 0,
  quantity SMALLINT NOT NULL DEFAULT 0,
  PRIMARY KEY (fk_order,fk_product)
);

CREATE TABLE orders (
  id     BIGSERIAL                NOT NULL,
  number BIGINT                   NOT NULL DEFAULT 0,
  time   TIME WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIME( 3 ),
  date   DATE                     NOT NULL DEFAULT CURRENT_DATE,
  PRIMARY KEY (id)
);

ALTER TABLE order_items
  ADD FOREIGN KEY (fk_order) REFERENCES orders (id)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE order_items
  ADD FOREIGN KEY (fk_product) REFERENCES product_items (id)
ON DELETE SET NULL
ON UPDATE CASCADE;

INSERT INTO db_version (version) VALUES ( 005 );

COMMIT TRANSACTION;

