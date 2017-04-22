BEGIN;

CREATE OR REPLACE VIEW  discounts_stats_ratio AS
  SELECT
    id,
    ( prev_price - price ) / prev_price AS discount_ratio,
    prev_price - price                  AS discount_abs
  FROM product_items
  WHERE prev_price IS NOT NULL
  ORDER BY discount_ratio DESC ;

INSERT into db_version(version) VALUES (002);


COMMIT;
