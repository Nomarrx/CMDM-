desc orders;
desc customers;
desc salespeople;

--1
SELECT ordernum, cusname
FROM orders o JOIN customers c ON o.customernum = c.customernum;

--2
SELECT cusname, salespname, commission
FROM customers c JOIN salespeople s ON c.salespersonnum = s.salespersonnum
WHERE commission > .12;

--3
SELECT s.salespersonnum, o.ordernum, s.commission * o.orderamount AS commission
FROM salespeople s JOIN customers c ON s.salespersonnum = c.salespersonnum
                   JOIN orders o ON o.customernum = c.customernum
WHERE  cusrating > 100;

--5
SELECT s.salespersonnum, salespname, ordernum, orderamount, orderdate
FROM salespeople s LEFT JOIN orders o ON s.salespersonnum = o.salespersonnum 
AND orderdate = '03-OCT-00'
ORDER BY salespname;
--or with UNION and subquery:
SELECT s.salespersonnum, salespname, ordernum, orderamount
FROM salespeople s JOIN orders o ON s.salespersonnum = o.salespersonnum 
WHERE orderdate  = TO_DATE('03-OCT-2000', 'DD-MON-YYYY')
UNION --  2nd part gets the other salespeople who don’t have orders that day
SELECT s.salespersonnum, salespname, null, null
FROM salespeople s LEFT JOIN orders o ON s.salespersonnum = o.salespersonnum 
WHERE s.salespersonnum NOT IN (SELECT salespersonnum FROM Orders WHERE orderdate  = TO_DATE('03-OCT-2000', 'DD-MON-YYYY') );

--6
SELECT c.customernum, cusname, s.salespersonnum, salespname
FROM customers c RIGHT JOIN salespeople s ON c.salespersonnum = s.salespersonnum;

--7
SELECT c.customernum, cusname, s.salespersonnum, salespname
FROM customers c LEFT JOIN salespeople s ON c.salespersonnum = s.salespersonnum
UNION
SELECT c.customernum, cusname, s.salespersonnum, salespname
FROM customers c RIGHT JOIN salespeople s ON c.salespersonnum = s.salespersonnum;
--OR Use a full outer join:
SELECT c.customernum, cusname, s.salespersonnum, salespname
FROM customers c FULL JOIN salespeople s ON c.salespersonnum = s.salespersonnum;

--8
SELECT e.empno, e.name, m.name
FROM employees e LEFT JOIN employees m ON e.manager = m.empno;

--9
SELECT salespersonnum AS PersonNum, salespname AS PersonName
FROM salespeople
WHERE salespcity = 'London'
UNION
SELECT customernum, cusname
FROM customers
WHERE cuscity = 'London';

--10
SELECT cusname, cuscity, cusrating, 'HIGH RATING' AS Rating
FROM customers
WHERE cusrating >= 200
UNION
SELECT cusname, cuscity, cusrating, 'LOW RATING'
FROM customers
WHERE cusrating < 200
  	OR cusrating IS NULL;

--11
SELECT s.salespersonnum, salespname
FROM salespeople s JOIN orders o ON s.salespersonnum = o.salespersonnum
GROUP BY s.salespersonnum, salespname
HAVING COUNT(*) > 1
UNION
SELECT c.customernum, cusname
FROM customers c JOIN orders o ON c.customernum = o.customernum
GROUP BY c.customernum, cusname
HAVING COUNT(*) > 1
ORDER BY 2;

--12
SELECT c.customernum, cusname, s.salespersonnum, salespname, s.salespcity
FROM customers c JOIN salespeople s ON c.cuscity = s.salespcity;

--13
SELECT ordernum, s.salespcity AS salescity, c.cuscity as custcity
FROM salespeople s JOIN Orders o ON s.salespersonnum = o.salespersonnum
JOIN customers c ON c.customernum = o.customernum
WHERE s.salespcity <> c.cuscity; -- can also put in JOIN ON with AND

--14
SELECT s1.salespersonnum, s1.salespname, s2.salespersonnum, s2.salespname, s1.salespcity
FROM salespeople s1 JOIN salespeople s2 ON s1.salespcity = s2.salespcity
WHERE s1.salespersonnum < s2.salespersonnum;

select salespcity, count(*) from salespeople group by salespcity; -- to verify only London has two

--15
--this is a good time to use a subquery, which we haven't taken yet
SELECT c1.cusname, c2.cusname, c2.cuscity, c2.cusrating
FROM customers c1 JOIN customers c2 ON c1.cusrating = c2.cusrating
WHERE c1.customernum = 2001 AND c2.customernum <> 2001;
-- Here is a subquery doing the same thing:
SELECT cusname, cuscity
FROM customers WHERE cusrating = (SELECT cusrating FROM customers WHERE customernum = 2001);
