SELECT * FROM orders;

SELECT orderdate,
	SUM(quantityOrdered * priceeach) AS SALES 
FROM orders LEFT JOIN orderdetails 
	ON orders.orderNumber = orderdetails.orderNumber
GROUP BY orderDate
ORDER BY orderDate;

#월별 매출액 조회 
SELECT SUBSTR('2023-01-19', 6, 2)

SELECT SUBSTR(orderdate, 1, 7) YM
	,SUM(quantityOrdered * priceeach) AS SALES 
FROM orders LEFT JOIN orderdetails 
	ON orders.orderNumber = orderdetails.orderNumber
GROUP BY orderDate
ORDER BY orderDate;

#연도별 매출액 조회 
SELECT SUBSTR(orderdate, 1, 4) YY
	,SUM(quantityOrdered * priceeach) AS SALES 
FROM orders LEFT JOIN orderdetails 
	ON orders.orderNumber = orderdetails.orderNumber
GROUP BY orderDate #또는 GROUP BY 1 
ORDER BY orderDate; #또는 ORDER BY 1

SELECT * 
FROM orders;

SELECT COUNT(ordernumber)
	,COUNT(DISTINCT ordernumber)
FROM orders;

SELECT orderdate
	,COUNT(DISTINCT customernumber) PURCHASER_CNT 
    ,COUNT(ordernumber) ORDERS_CNT
FROM orders
GROUP BY 1
ORDER BY 1;

#월별 
SELECT SUBSTR(orderdate, 1, 7) YM
	,COUNT(DISTINCT customernumber) PURCHASER_CNT 
    ,COUNT(ordernumber) ORDERS_CNT
FROM orders
GROUP BY YM
ORDER BY YM;

#연도별 
SELECT SUBSTR(orderdate, 1, 4) YY
	,COUNT(DISTINCT customernumber) PURCHASER_CNT 
    ,COUNT(ordernumber) ORDERS_CNT
FROM orders
GROUP BY YY
ORDER BY YY;

#고객 인당 매출 
SELECT SUBSTR(orderdate, 1, 4) YY
	,COUNT(DISTINCT customernumber) PURCHASER_CNT 
    ,SUM(quantityordered * priceeach) AS SALES
    ,SUM(quantityordered * priceeach) / COUNT(DISTINCT customernumber) AMV
FROM orders LEFT JOIN orderdetails
	ON orders.ordernumber = orderdetails.ordernumber
GROUP BY 1
ORDER BY 1;

#건당 구매 매출액 
SELECT SUBSTR(orderdate, 1, 4) YY
	,COUNT(orders.ordernumber) ORDERS_CNT 
    ,SUM(quantityordered * priceeach) AS SALES
    ,SUM(quantityordered * priceeach) / COUNT(orders.ordernumber) ATV
FROM orders LEFT JOIN orderdetails
	ON orders.ordernumber = orderdetails.ordernumber
GROUP BY 1
ORDER BY 1;

#도시별 구매 매출액 
SELECT country
	, city
    , SUM(quantityOrdered * priceeach) AS SALES 
FROM orders LEFT JOIN orderdetails 
	ON orders.ordernumber = orderdetails.ordernumber 
    LEFT JOIN customers
    ON orders.customerNumber = customers.customernumber
    GROUP BY 1, 2
    ORDER BY SALES DESC; 
    
#북미 VS 북미 X 구매 매출액 
SELECT CASE WHEN country IN ('USA', 'Canada') THEN 'North America'
	ELSE 'others' END AS country_grp 
FROM customers;

SELECT CASE WHEN country IN ('USA', 'Canada') THEN 'North America'
	ELSE 'others' END AS country_grp 
, SUM(quantityOrdered * priceeach) AS SALES 
FROM orders LEFT JOIN orderdetails 
	ON orders.ordernumber = orderdetails.ordernumber 
    LEFT JOIN customers
    ON orders.customerNumber = customers.customernumber
    GROUP BY 1
    ORDER BY SALES DESC; 
 
 #매출 top 5국가 
 SELECT * 
 FROM
	(SELECT country 
		, SALES
		, DENSE_RANK() OVER (ORDER BY SALES DESC) RNK
	FROM 
	(SELECT country
		, SUM(quantityOrdered * priceeach) AS SALES 
	FROM orders LEFT JOIN orderdetails 
		ON orders.ordernumber = orderdetails.ordernumber 
		LEFT JOIN customers
		ON orders.customerNumber = customers.customernumber
		GROUP BY 1
		ORDER BY SALES DESC) AS STAT) AS STAT_RNK
WHERE RNK BETWEEN 1 AND 5; 

 #매출 top 5국가 
SELECT country 
		, SALES
		, DENSE_RANK() OVER (ORDER BY SALES DESC) RNK
	FROM 
	(SELECT country
		, SUM(quantityOrdered * priceeach) AS SALES 
	FROM orders LEFT JOIN orderdetails 
		ON orders.ordernumber = orderdetails.ordernumber 
		LEFT JOIN customers
		ON orders.customerNumber = customers.customernumber
		GROUP BY 1
		ORDER BY SALES DESC) AS STAT
LIMIT 5; 

#WINDOW 함수 설명 
