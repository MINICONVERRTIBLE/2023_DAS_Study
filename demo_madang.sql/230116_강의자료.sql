SELECT * 
FROM book;

SELECT bookname, publisher 
FROM book;

SELECT bookname, publisher 
FROM book
WHERE price >= 10000;

SELECT publisher, bookname
FROM book;

SELECT DISTINCT publisher 
FROM book;

SELECT *
FROM book
WHERE price < 20000;

SELECT *
FROM book
WHERE price BETWEEN 13000 AND 20000;

SELECT *
FROM book
WHERE publisher NOT IN ('굿스포츠', '대한미디어');

SELECT *
FROM book
WHERE bookname LIKE '%축구%';

SELECT *
FROM book
WHERE bookname LIKE '축구%';

SELECT *
FROM book
WHERE bookname LIKE '_구%'; #와일드문자라고 함

SELECT * 
FROM book 
WHERE bookname LIKE '%축구%' AND price >= 20000;

SELECT * 
FROM book
WHERE publisher IN ('굿스포츠','대한미디어');

SELECT * 
FROM book
ORDER BY price DESC, publisher;

SELECT SUM(saleprice) AS 총매출
FROM orders;

SELECT SUM(saleprice) AS 2번고객총매출 
FROM orders
WHERE custid = 2;

SELECT SUM(saleprice) AS 2번고객평균매출 
FROM orders
WHERE custid = 2;

SELECT MAX(saleprice) AS 2번고객최대매출 
FROM orders
WHERE custid = 2;

SELECT MIN(saleprice) AS 2번고객최소매출 
FROM orders
WHERE custid = 2;

SELECT SUM(saleprice)
	,AVG(saleprice)
    ,MIN(saleprice)
    ,MAX(saleprice)
	,COUNT(saleprice)
FROM orders;

SELECT custid
	,COUNT(*)AS 도서수량
    ,SUM(saleprice) AS 총판매액
FROM orders
GROUP BY custid;

SELECT custid
	,COUNT(*)AS 도서수량
    ,SUM(saleprice) AS 총판매액
FROM orders
GROUP BY custid;

SELECT custid, COUNT(*) 
FROM orders
WHERE saleprice >= 8000 
GROUP BY custid
HAVING COUNT(*) >= 2;
#HAVING은 WHERE 뒤에, HAVING 뒤에는 반드시 집계함수! 





