BEGIN;

CREATE TABLE IF NOT EXISTS product_items (
  id          SERIAL UNIQUE                 NOT NULL,
  article     VARCHAR(50)                   NOT NULL,
  title       VARCHAR(200)                  NOT NULL,
  price       DECIMAL UNSIGNED              NOT NULL DEFAULT 0,
  prev_price  DECIMAL UNSIGNED,
  icon        VARCHAR(50)                   NOT NULL DEFAULT 'no_icon.png',
  record_date DATE,
  quantity    INTEGER UNSIGNED              NOT NULL DEFAULT 0,
  PRIMARY KEY (id)
);

CREATE INDEX article_indx
  ON product_items (article(6) ASC) USING BTREE;

CREATE INDEX price_indx
  ON product_items (price ASC) USING BTREE;

CREATE INDEX date_indx
  ON product_items (record_date ASC) USING BTREE;

CREATE TABLE db_version (
  version TINYINT  NOT NULL,
  date    DATETIME NOT NULL DEFAULT current_timestamp ON UPDATE current_timestamp
);

CREATE INDEX db_version_date_indx ON db_version(date DESC );

INSERT INTO db_version (version) VALUES ( 001 );

COMMIT;