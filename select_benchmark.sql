SELECT *
FROM product_items
ORDER BY record_date DESC
LIMIT 10
OFFSET 0;
/*PGSQL
на 1000 записей
без индекса - 10ms (execution: 5ms, fetching: 5ms)
с индексом - 17ms (execution: 6ms, fetching: 11ms)

на 1000000 записей
без индекса - 506ms (execution: 473ms, fetching: 33ms)
с индексом - 128ms (execution: 65ms, fetching: 63ms)

MYSQL

на 1000 записей
без индекса -  137ms (execution: 104ms, fetching: 33ms)
с индексом - 13ms (execution: 6ms, fetching: 7ms)
            - in file 0.00 sec

на 1000000 записей
без индекса -988ms (execution: 978ms, fetching: 10ms)
с индексом - 104ms (execution: 59ms, fetching: 45ms)



*/

SELECT *
FROM product_items
ORDER BY price
LIMIT 10
OFFSET 0;
/*PGSQL
на 1000 записей
без индекса - 13ms (execution: 6ms, fetching: 7ms)
с индексом - 23ms (execution: 9ms, fetching: 14ms)

на 1000000 записей
без индекса - 355ms (execution: 336ms, fetching: 19ms)
с индексом - 34ms (execution: 10ms, fetching: 24ms)

MYSQL

на 1000 записей
без индекса -  32ms (execution: 7ms, fetching: 25ms)
с индексом - 10ms (execution: 4ms, fetching: 6ms)
          - in file 0.00 sec

на 1000000 записей
без индекса -989ms (execution: 977ms, fetching: 12ms)
с индексом - 38ms (execution: 12ms, fetching: 26ms)


*/



SELECT * from discounts_stats ORDER BY discount_abs DESC ;

/*

MYSQL
на 1000 записей после создание представления discount_abs

14ms (execution: 5ms, fetching: 9ms)

1000000 записей

-in file 2.04
explain показал что перебираются все записи(медленное выполнение, using filesort)

profiling
starting	0.000024
checking permissions	0.000003
Opening tables	0.000053
checking permissions	0.000002
checking permissions	0.000017
init	0.000021
checking permissions	0.000010
System lock	0.000005
optimizing	0.000006
statistics	0.000014
preparing	0.000008
Sorting result	0.000002
executing	0.000002
Sending data	0.000006
                        Creating sort index	7.025603
end	0.000025
query end	0.000008
closing tables	0.000029
freeing items	0.000034
cleaning up	0.000036


*/

SELECT * from discounts_stats ORDER BY discount_ratio DESC ;
/*
на 1000 записей после создание представления discount_abs

22ms (execution: 8ms, fetching: 14ms)

1000000 recs
-infile 2.18 sec

explain показал что перебираются все записи(медленное выполнение, using filesort)

profiling
starting	0.000024
checking permissions	0.000003
Opening tables	0.000048
checking permissions	0.000002
checking permissions	0.000014
init	0.000018
checking permissions	0.000010
System lock	0.000005
optimizing	0.000006
statistics	0.000013
preparing	0.000010
Sorting result	0.000003
executing	0.000002
Sending data	0.000007
                        Creating sort index	7.147946
end	0.000016
query end	0.000008
closing tables	0.000029
freeing items	0.000076
cleaning up	0.000017


*/




SELECT * FROM product_items WHERE article ~* '^TEST';

/*PGSQL
на 1000 записей
без индекса - 43ms (execution: 8ms, fetching: 35ms)
с индексом  - 78ms (execution: 11ms, fetching: 67ms)

на 1000000 записей
без индекса - 108ms (execution: 9ms, fetching: 99ms)
с индексом - 96ms (execution: 23ms, fetching: 73ms)

разницы нет, как правильно сделать индекс?


*/

SELECT * from product_items where article LIKE 'TEST%';


/*PGSQL
на 1000 записей
без индекса  - 33ms (execution: 5ms, fetching: 28ms)
с индексом  - 94ms (execution: 12ms, fetching: 82ms)

на 1000000 записей
без индекса - 65ms (execution: 13ms, fetching: 52ms)
с индексом - 90ms (execution: 11ms, fetching: 79ms)

разницы нет, как правильно сделать индекс?

MYSQL

на 1000 записей
без индекса -  111ms (execution: 15ms, fetching: 96ms)
с индексом - 61ms (execution: 16ms, fetching: 45ms)

на 1000000 записей
без индекса - 62ms (execution: 7ms, fetching: 55ms)
с индексом - 37ms (execution: 11ms, fetching: 26ms)
-infile 1.99sec

запрос explain  показал что в данном запросе индекс article_indx  не используется и перебираются все строки(Using where)
profiling
starting	0.000037
checking permissions	0.000003
Opening tables	0.000015
init	0.000022
System lock	0.000006
optimizing	0.000006
statistics	0.002130
preparing	0.000010
executing	0.000002
Sending data	6.992779
end	0.000010
query end	0.000006
closing tables	0.000007
freeing items	0.000011
cleaning up	0.000012


*/