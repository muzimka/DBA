/*Запрос, который выберет категории и среднюю цену товаров в каждой категории, при условии,
что эта средняя цена менее 10000 рублей (выбираем "бюджетные" категории товаров)*/


--1
--  цена запроса   2.2601631E7
--
SELECT
  pt.label,
  ( SELECT avg( pi.price ) AS avg
    FROM product_items pi
    WHERE pi.type_id = pt.id ) AS averg
FROM product_type pt
WHERE ( SELECT avg( pi.price )
        FROM product_items pi
        WHERE pi.type_id = pt.id ) < 10000;

--2
--цена запроса 1.7160543E7
--

SELECT
  pt.label,
  avg( pi.price )
FROM product_items pi, product_type pt
WHERE pi.type_id = pt.id AND
      ( SELECT avg( pi.price )
        FROM product_items pi
        WHERE pi.type_id = pt.id ) < 10000
GROUP BY pt.label;

--3
-- цена запроса 65806.0
--

SELECT
  pt.label,
  avg( price ) < 10000 AS budget_or_not
FROM product_items pi, product_type pt
WHERE pi.type_id = pt.id
GROUP BY pt.label;

--4
--цена запроса 65810.0
--


WITH avr_prices AS ( SELECT
                       pt.label     AS category,
                       avg( price ) AS average
                     FROM product_items pi, product_brand pt
                     WHERE pi.type_id = pt.id
                     GROUP BY pt.label)
SELECT
  'Бюджетная категория до 10 000' AS c2,
  a.category,
  'со средней ценой'              AS c1,
  a.average
FROM avr_prices a

WHERE a.average < 10000;

--5
-- цена запроса 35141.0
--

SELECT
  pt.label        AS category,
  avg( pi.price ) AS av_price
FROM product_type pt
  INNER JOIN product_items pi ON pt.id = pi.type_id
GROUP BY pt.label
HAVING avg( pi.price ) < 10000;


/*  Улучшите предыдущий запрос таким образом, чтобы в расчет средней цены включались только товары, имеющиеся на складе.*/

-- cost 68061.0
--

WITH avr_prices AS ( SELECT
                       pt.id           AS cat_id,
                       pt.label        AS category,
                       avg( pi.price ) AS average
                     FROM product_items pi, product_type pt
                     WHERE pi.type_id = pt.id AND pi.quantity > 0

                     GROUP BY pt.id, pt.label)
SELECT
  'Бюджетная категория до 10 000' AS c2,
  a.cat_id,
  a.category,
  'со средней ценой'              AS c1,
  a.average
FROM avr_prices a

WHERE a.average < 10000;

/*
Напишите запрос, который для каждой категории и класса брендов,
представленных в категории выберет среднюю цену товаров.*/

-- cost  without order by 396424.0
--         with order by  396500.0
--

SELECT
  cb.label                     AS class,
  ( SELECT pt.label
    FROM product_type pt
    WHERE pi.type_id = pt.id ) AS category,
  avg( pi.price )              AS avg_price

FROM product_items pi, product_brand pb, class_brand cb

WHERE pi.brand_id = pb.id AND pb.fid_class = cb.id
GROUP BY cb.label, pi.type_id
ORDER BY cb.label;

--
-- cost 2.147483647E9 !!! класс бренда мой комп не может вытянут даже на 5-ти записях.  так что убрал их


WITH product AS (
    SELECT
      pi.brand_id AS every_brand,
      pi.type_id  AS every_type
    FROM product_items pi
)
SELECT (
         pt.label,
         ( SELECT sum( pi.price ) AS sum
           FROM product_items pi
           WHERE pi.type_id = p.every_type AND pi.brand_id = p.every_brand ) /

         ( SELECT count( * ) AS count
           FROM product_items pi
           WHERE pi.type_id = p.every_type AND pi.brand_id = p.every_brand )


       ) AS result
FROM product p, product_type pt
WHERE p.every_type = pt.id;

/*апишите запрос, который выведет таблицу с полями
 "дата",
  "число заказов за дату",
   "сумма заказов за дату".
  */

-- цена 8520.0
--
--

SELECT
  o.date                        AS date,
  'совершено'                   AS c1,
  count( o.id )                    orders_per_day,
  'заказов на общую сумму'      AS c2,
  sum( oi.quantity * pi.price ) AS sum_per_day
FROM orders o
  INNER JOIN order_items oi ON o.id = oi.fk_order
  INNER JOIN product_items pi ON oi.fk_product = pi.id
GROUP BY date
ORDER BY date;


/*Улучшите этот запрос, введя группировку по признаку "дешевый товар", "средняя цена", "дорогой товар".
 В итоге должно получиться "дата", "группа по цене", "число заказов", "сумма заказов"*/


--Критерии категоризации:
--ДЕШЕВЫЙ  : цена товара ниже средней на 2000 и менее
--СРЕДНЕЦЕНОВОЙ : цена товара равна средней цене с отклонением +-2000 рублей
--ДОРОГОЙ : цена товара выше средней на 2000 и более


-- цена запроса 86948.0

WITH avg_price AS (
    SELECT avg( prd.price ) AS av_pr
    FROM product_items prd
)

SELECT
  count( o.id )                    orders_per_day,
  'заказов в категории товара'             AS c1,
  CASE
WHEN pi.price < ap.av_pr - 2000
THEN 'ДЕШЕВЫЙ'
WHEN pi.price > ap.av_pr - 2000 AND pi.price < ap.av_pr + 2000
THEN 'СРЕДНЕЦЕНОВОЙ'
ELSE 'ДОРОГОЙ'
END                           AS gr,
  'на дату' c3,
  o.date                        AS date,
  'на общую сумму'      AS c2,
  sum( oi.quantity * pi.price ) AS sum_per_day
FROM avg_price ap, orders o
  INNER JOIN order_items oi ON o.id = oi.fk_order
  INNER JOIN product_items pi ON oi.fk_product = pi.id
GROUP BY gr, date
ORDER BY date
;




