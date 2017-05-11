START TRANSACTION;

CREATE TABLE order_items (
  fk_order   INTEGER         NOT NULL DEFAULT 0,
  fk_product BIGINT UNSIGNED NOT NULL DEFAULT 0,
  quantity   SMALLINT        NOT NULL DEFAULT 0,
  PRIMARY KEY (fk_order, fk_product)
);


CREATE TABLE orders (
  id     INTEGER                       AUTO_INCREMENT,
  number BIGINT NOT NULL               DEFAULT 0,
  dt     TIMESTAMP                     DEFAULT current_timestamp ON UPDATE current_timestamp,
  PRIMARY KEY (id)
);


ALTER TABLE order_items
  ADD FOREIGN KEY (fk_order) REFERENCES orders (id)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

ALTER TABLE order_items
  ADD FOREIGN KEY (fk_product) REFERENCES product_items (id)
ON DELETE RESTRICT
ON UPDATE CASCADE;

INSERT INTO db_version (version) VALUES ( 005 );

COMMIT;


