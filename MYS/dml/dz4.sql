/*-----1 Выберут все товары с указанием их категории и бренда------*/
SELECT
  `pi`.`id`    AS product_id,
  `pi`.`article`,
  `pi`.`price`,
  `pi`.`prev_price`,
  `br`.`label` AS brand,
  `tp`.`label` AS category
FROM product_items pi
  INNER JOIN
  `product_type` tp ON ( `pi`.`type_id` = `tp`.`id` )
  INNER JOIN
  `product_brand` br ON ( `pi`.`brand_id` = `br`.`id` )
ORDER BY `pi`.`id`;


SELECT
  `pi`.`id`    AS product_id,
  `pi`.`article`,
  `pi`.`price`,
  `pi`.`prev_price`,
  `br`.`label` AS brand,
  `tp`.`label` AS category
FROM
  product_items AS pi,
  product_brand AS br,
  product_type  AS tp
WHERE `pi`.`brand_id` = `br`.`id` AND `pi`.`type_id`= `tp`.`id`
ORDER BY `pi`.`id`;

/*------2 Выберут все товары, бренд которых начинается на букву "А"---------*/

SELECT
  `p`.`id`,
  `p`.`article`,
  `p`.`price`,
  `br`.`label` AS brand
FROM `product_items` AS `p`, `product_brand` AS `br`
WHERE
  `br`.`label` LIKE 'Б%';

/*-----3 Выведут список категорий и число товаров в каждой--------*/

SELECT
  (
    SELECT count( `product_items`.`id` )
    FROM `product_items`
    WHERE `product_items`.`type_id` = `pt`.`id`
  )                     AS total,
  'товаров в категории' AS comment,
  `label`                  category
FROM `product_type` pt;


/*-----4 Выберут для каждой категории список брендов товаров, входящих в нее--------*/

SELECT DISTINCT
  'В категории' AS    comment,
  `label`               category,
  'участвует производитель' br_comment,
  (
    SELECT `label`
    FROM `product_brand`
WHERE `product_brand`.`id` = `pi`.`brand_id`
)               AS    brand
FROM
  `product_type` prt,
  `product_items` pi
WHERE `pi`.`type_id` = `prt`.`id`

