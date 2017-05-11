/*Запрос, который выберет категории и среднюю цену товаров в каждой категории, при условии,
что эта средняя цена менее 10000 рублей (выбираем "бюджетные" категории товаров)*/


-- 1
--
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

-- 2
--
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

-- 3
--
--

SELECT
  pt.label,
  avg( price ) < 10000 AS budget_or_not
FROM product_items pi, product_type pt
WHERE pi.type_id = pt.id
GROUP BY pt.label;

-- 4
--
--

SELECT
  pt.label        AS category,
  avg( pi.price ) AS av_price
FROM product_type pt
  INNER JOIN product_items pi ON pt.id = pi.type_id
GROUP BY pt.label
HAVING avg( pi.price ) < 10000;


/*  Улучшите предыдущий запрос таким образом, чтобы в расчет средней цены включались только товары, имеющиеся на складе.*/

-- 1
--
SELECT
  pt.label        AS category,
  avg( pi.price ) AS av_price
FROM product_type pt
  INNER JOIN product_items pi ON pt.id = pi.type_id
WHERE pi.quantity > 0
GROUP BY pt.label
HAVING avg( pi.price ) < 10000;

-- 2
--

SELECT
  pt.label        AS category,
  avg( pi.price ) AS av_price
FROM product_type pt
  INNER JOIN product_items pi ON pt.id = pi.type_id
                                 AND pi.quantity > 0
GROUP BY pt.label
HAVING avg( pi.price ) < 10000;

-- 3
--

SELECT
  pt.label        AS category,
  avg( pi.price ) AS av_price
FROM product_type pt
  INNER JOIN product_items pi ON pt.id = pi.type_id
  INNER JOIN product_items pi2 ON pi2.quantity > 0
GROUP BY pt.label
HAVING avg( pi.price ) < 10000;


/*
Напишите запрос, который для каждой категории и класса брендов,
представленных в категории выберет среднюю цену товаров.*/

-- 1
--
SELECT
  cb.label AS class,
  pt.label AS cat,
  avg( pi.price )
FROM product_items pi
  INNER JOIN product_type pt ON pi.type_id = pt.id
  INNER JOIN product_brand pb ON pi.brand_id = pb.id
  INNER JOIN class_brand cb ON pb.fid_class = cb.id
GROUP BY class, cat;

-- 2
-- выбирает также те товары у которых есть класс но нет категории(outer join)

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


/*Напишите запрос, который выведет таблицу с полями
 "дата",
  "число заказов за дату",
   "сумма заказов за дату".
  */

--
--
--
SELECT
  date_format( o.dt, get_format( DATE, 'ISO' ) ) AS date,
  'совершено'                                    AS c1,
  count( o.id )                                     orders_per_day,
  'заказов на общую сумму'                       AS c2,
  sum( oi.quantity * pi.price )                  AS sum_per_day
FROM orders o
  INNER JOIN order_items oi ON o.id = oi.fk_order
  INNER JOIN product_items pi ON oi.fk_product = pi.id
GROUP BY date
ORDER BY date;


/*Улучшите этот запрос, введя группировку по признаку "дешевый товар", "средняя цена", "дорогой товар".
 В итоге должно получиться "дата", "группа по цене", "число заказов", "сумма заказов"*/


-- Критерии категоризации:
-- ДЕШЕВЫЙ  :цена товара ниже средней на 2000 и менее
-- СРЕДНЕЦЕНОВОЙ :цена товара равна средней цене с отклонением +-2000 рублей
-- ДОРОГОЙ :цена товара выше средней на 2000 и более


-- 1
-- (execution: 2s 954ms, fetching: 18ms)

SELECT
  count( o.id )                                     orders_per_day,
  'заказов в категории товара'                   AS c1,
  CASE
  WHEN pi.price < (SELECT avg( price ) AS av_pr
                   FROM product_items ) - 2000
    THEN 'ДЕШЕВЫЙ'
  WHEN pi.price > (SELECT avg( price ) AS av_pr
                   FROM product_items )- 2000 AND pi.price < (SELECT avg( price ) AS av_pr
                   FROM product_items ) + 2000
    THEN 'СРЕДНЕЦЕНОВОЙ'
  ELSE 'ДОРОГОЙ'
  END                                            AS gr,
  'на дату'                                         c3,
  date_format( o.dt, get_format( DATE, 'ISO' ) ) AS date,
  'на общую сумму'                               AS c2,
  sum( oi.quantity * pi.price )                  AS sum_per_day
FROM orders o
  INNER JOIN order_items oi ON o.id = oi.fk_order
  INNER JOIN product_items pi ON oi.fk_product = pi.id
GROUP BY gr, date
ORDER BY date;


-- 2
-- 512ms + 1s 921ms + 2 ms = total 2s 440 ms


START TRANSACTION ;

SET @avg_price = ( SELECT avg( price ) AS av_pr
                   FROM product_items );

SELECT
  count( o.id )                                     orders_per_day,
  'заказов в категории товара'                   AS c1,
  CASE
  WHEN pi.price < @avg_price - 2000
    THEN 'ДЕШЕВЫЙ'
  WHEN pi.price > @avg_price - 2000 AND pi.price < @avg_price + 2000
    THEN 'СРЕДНЕЦЕНОВОЙ'
  ELSE 'ДОРОГОЙ'
  END                                            AS gr,
  'на дату'                                         c3,
  date_format( o.dt, get_format( DATE, 'ISO' ) ) AS date,
  'на общую сумму'                               AS c2,
  sum( oi.quantity * pi.price )                  AS sum_per_day
FROM orders o
  INNER JOIN order_items oi ON o.id = oi.fk_order
  INNER JOIN product_items pi ON oi.fk_product = pi.id
GROUP BY gr, date
ORDER BY date;

SET @avg_price = NULL;
COMMIT ;

