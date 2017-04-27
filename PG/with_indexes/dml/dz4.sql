/*-----1 Выберут все товары с указанием их категории и бренда------*/
SELECT
  pi.id    AS product_id,
  pi.article,
  pi.price,
  pi.prev_price,
  pt.label AS category,
  pb.label AS brand
FROM product_items pi
  LEFT OUTER JOIN
  product_type pt ON ( pi.type_id = pt.id )
  LEFT OUTER JOIN product_brand pb ON ( pi.brand_id = pb.id );


/*------2 Выберут все товары, бренд которых начинается на букву "А"---------*/

SELECT
  pi.id,
  pb.label
FROM product_items pi
  INNER JOIN product_brand pb
    ON pb.label LIKE 'Б%' AND
       pi.brand_id = pb.id;

/*-----3 Выведут список категорий и число товаров в каждой--------*/

SELECT
  (
    SELECT count( product_items.id )
    FROM product_items
    WHERE product_items.type_id = pt.id
  )                     AS total,
  'товаров в категории' AS comment,
  label                    category
FROM product_type pt;


/*-----4 Выберут для каждой категории список брендов товаров, входящих в нее--------*/

--
--cost 393694.0  --

SELECT
  'В категорию',
  pt.label AS type,
  'входит брэнд',
  pb.label AS brand
FROM product_items pi
  INNER JOIN product_type pt ON pi.type_id = pt.id
  INNER JOIN product_brand pb ON pi.brand_id = pb.id
GROUP BY pt.label, pb.label;

-- cost 8273384.0

SELECT DISTINCT
  'В категории' AS          comment,
  label                     category,
  'участвует производитель' br_comment,
  (
    SELECT label
    FROM product_brand
    WHERE product_brand.id = pi.brand_id
  )             AS          brand
FROM
  product_type prt,
  product_items pi
WHERE pi.type_id = prt.id;

--
-- costs 550873.0
--

SELECT
  'В категорию',
  pt.label,
  'входит брэнд',
  pb.label
FROM product_items pi, product_type pt, product_brand pb
WHERE pi.type_id = pt.id AND pi.brand_id = pb.id
GROUP BY (pt.label, pb.label);




