SELECT  *
FROM customer, orders;

#정렬을 할때 어떤 컬럼인지 지정을 별도로 해주어야한다! 
SELECT  *
FROM customer, orders
WHERE customer.custid = orders.custid
ORDER BY customer.custid;

SELECT name, saleprice, customer.custid
FROM customer, orders
WHERE customer.custid = orders.custid
ORDER BY customer.custid;

SELECT name, SUM(saleprice) AS 총판매액
FROM customer, orders
WHERE customer.custid = orders.custid
GROUP BY customer.name
ORDER BY customer.name;

SELECT customer.name, book.bookname 
FROM customer, orders, book 
WHERE customer.custid = orders.custid
	AND orders.bookid = book.bookid; 
    
SELECT customer.name, book.bookname 
FROM customer, orders, book 
WHERE customer.custid = orders.custid
	AND orders.bookid = book.bookid
    AND book.price = 20000; 

SELECT * 
FROM customer INNER JOIN orders 
	ON customer.custid = orders.custid;

SELECT name, saleprice 
FROM customer LEFT OUTER JOIN orders 
ON customer.custid = orders.custid;

#FULL JOIN은 안됨?
SELECT * 
FROM customer FULL JOIN orders 
ON customer.custid = orders.custid;   

#실제 max(price)의 bookname이 아님 
SELECT MAX(price), bookname
FROM book; 

#서브쿼리
SELECT bookname
FROM book
WHERE price = (SELECT MAX(price)
				FROM book); 
                
SELECT DISTINCT name
FROM customer INNER JOIN orders 
	ON customer.custid = orders.custid;

#서브쿼리의 속도가 join보다 훨씬 빠름!     
SELECT name
FROM customer
WHERE custid IN (SELECT custid
				FROM orders); 
                
SELECT name
FROM customer INNER JOIN orders
	ON customer.custid = orders.custid 
    INNER JOIN book 
    ON orders.bookid = book.bookid
WHERE publisher = '대한미디어'; 

SELECT name 
FROM customer 
WHERE custid IN 
	(SELECT custid 
	FROM orders
	WHERE bookid IN
		(
		SELECT bookid
		FROM book 
		WHERE publisher = '대한미디어')); 

SELECT publisher, AVG(price)
FROM book 
GROUP BY publisher;

SELECT *
FROM book;

#부속질의 
SELECT b1.bookname
FROM book b1 
WHERE price > (SELECT AVG(price)
				FROM book b2 
                WHERE b2.publisher = b1.publisher
                );
                
#집합 연산
SELECT name 
FROM customer
WHERE address LIKE '대한민국%'
UNION ALL
SELECT name
FROM customer
WHERE custid IN (
	SELECT custid
    FROM orders); 
    
SELECT name, address  
FROM customer 
WHERE custid IN (
	SELECT custid 
    FROM orders);
    
SELECT name, address  
FROM customer 
WHERE EXISTS(
	SELECT *
    FROM orders
    WHERE customer.custid = orders.custid);
    
SELECT name, address  
FROM customer 
WHERE custid NOT IN (
	SELECT custid 
    FROM orders);
    
SELECT name, address  
FROM customer 
WHERE NOT EXISTS(
	SELECT *
    FROM orders
    WHERE customer.custid = orders.custid);

#LIMIT 앞 위치, 뒤 개수 
SELECT * 
FROM BOOK 
ORDER BY price DESC
LIMIT 3, 4; 

SELECT ABS(-78);
SELECT ABS(78);
SELECT ROUND(4.875, 1);

SELECT custid '고객번호', ROUND(AVG(saleprice),-2) 
FROM orders 
GROUP BY custid;

#코테에 은근히 자주 나옴 
SELECT MOD(7, 2);

SELECT CONCAT('마당','서점');

SELECT CONCAT(custid, '_', bookid)
FROM orders;

SELECT SUBSTR('2023-01-17', 1, 4);

SELECT TRIM('   SQL');

SELECT TRIM('   S  Q  L');

SELECT TRIM('_'FROM'__S_Q_L___');

SELECT LENGTH('데이터');
SELECT CHAR_LENGTH('데이터');
SELECT LENGTH('abc');
SELECT CHAR_LENGTH('abc');

#값이 실제로는 바뀌지 않음 
SELECT bookid 
	,bookname 
    ,REPLACE(bookname, '야구', '농구')
FROM book;

SELECT SYSDATE();

SELECT SUBSTR(DATE_FORMAT(orderdate, '%Y-%m-%d'),1, 4)
FROM orders;

SELECT DATE(orderdate)
FROM orders;

SELECT orderid
	,orderdate
    ,ADDDATE(orderdate, INTERVAL 10 DAY) '확정'
FROM orders;

SELECT * 
FROM orders
WHERE orderdate LIKE '2014%';

SET @seq:=0;
SELECT (@seq:=@seq+1), custid, name
FROM customer
LIMIT 2;

SET @seq:=0;
SELECT (@seq:=@seq+1), custid, name
FROM customer
WHERE @seq < 2;