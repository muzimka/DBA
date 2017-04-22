
BEGIN;

CREATE TABLE IF NOT EXISTS product_items (
  id          SERIAL UNIQUE                 NOT NULL,
  article     VARCHAR(50)                   NOT NULL,
  title       VARCHAR(200)                  NOT NULL,
  price       DECIMAL UNSIGNED              NOT NULL DEFAULT 0,
  prev_price  DECIMAL UNSIGNED,
  icon        VARCHAR(50) NOT NULL DEFAULT 'no_icon.png',
  record_date DATE,
  quantity    INTEGER UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (id)
);

COMMIT;