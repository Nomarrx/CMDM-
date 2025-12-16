--Exercise 2

--1
SELECT COUNT(*)
FROM Orders
WHERE orderdate = '03-OCT-00';


--2
SELECT customernum, MIN(orderamount)
FROM Orders
GROUP BY customernum;

--3
SELECT MIN(cusname)
FROM Customers
WHERE cusname LIKE 'G%';

--4
SELECT cuscity, MAX(cusrating)
FROM Customers
GROUP BY cuscity;

--5
SELECT orderdate, COUNT(DISTINCT salespersonnum)
FROM Orders
GROUP BY orderdate;

--6
SELECT 'For the city ' || RTRIM(cuscity) || ', the highest rating is: ' 
|| MAX(cusrating) AS "Maximum Rating per City"
FROM Customers
GROUP BY cuscity;

--7
SELECT *
FROM Customers
ORDER BY cusrating DESC, cusname;

--8
SELECT SUM(orderamount), orderdate
FROM Orders
GROUP BY orderdate
ORDER BY 1 DESC; 

--9
SELECT salespcity, MAX(commission) FROM Salespeople 
GROUP BY salespcity HAVING COUNT(*) >= 2;

--10
SELECT customernum, SUM(orderamount) FROM Orders
GROUP BY customernum HAVING SUM(orderamount) > 4000;

--11
SELECT MAX(COUNT(*)) FROM Orders GROUP BY orderdate;

--12
SELECT orderdate, TO_CHAR(SUM(orderamount) / COUNT(*), '$999,999.00'), 
AVG(orderamount) FROM Orders GROUP BY orderdate;
