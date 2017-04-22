START TRANSACTION;

CREATE DOMAIN price_dom AS DECIMAL(8, 2)
CONSTRAINT unsigned CHECK (VALUE >= 0);


CREATE DOMAIN photo_dom AS VARCHAR(50)
CONSTRAINT photo CHECK (VALUE ~ '^\w+\.(?:png|jpg|gif|jpeg)$');


CREATE TABLE IF NOT EXISTS product_items (
  id          SERIAL UNIQUE                 NOT NULL,
  article     VARCHAR(50)                   NOT NULL,
  title       VARCHAR(200)                  NOT NULL,
  price       "price_dom"                   NOT NULL DEFAULT 0,
  prev_price  "price_dom",
  icon        "photo_dom"                   NOT NULL DEFAULT 'no_icon.png',
  record_date DATE,
  quantity    INTEGER CHECK (quantity >= 0) NOT NULL DEFAULT 0,
  PRIMARY KEY (id)
);

CREATE TABLE db_version (
  version SMALLINT  NOT NULL,
  date    TIMESTAMPTZ NOT NULL DEFAULT current_timestamp
);

CREATE INDEX price_indx ON product_items USING BTREE (price);
CREATE INDEX prev_price_indx ON product_items USING BTREE (prev_price);
CREATE INDEX article_indx ON product_items USING BTREE (article);
CREATE INDEX  date_indx ON product_items USING BTREE (record_date);

INSERT INTO db_version (version) VALUES ( 001 );


COMMIT TRANSACTION;
