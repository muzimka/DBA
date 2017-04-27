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
  avg( price )
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
                     FROM product_items pi, product_type pt
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
-- после первого запроса создается таблица
--данные в ней не обновляются
-- цена второго запроса  13.0
--после использования таблицу надо удалять
--

SELECT
  pt.label     AS category,
  avg( price ) AS average
INTO avr
FROM product_items pi, product_type pt
WHERE pi.type_id = pt.id
GROUP BY pt.label;

SELECT * from avr WHERE avr.average<10000;

DROP TABLE avr;

/*4  и 3  запросы самые оптимальные.*/