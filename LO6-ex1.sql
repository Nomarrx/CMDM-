--1
SELECT OrderNum, OrderAmount, OrderDate FROM Orders;

--2
SELECT * FROM Customers WHERE SALESPERSONNUM = 1001;

--3
SELECT SalesPCity, SalesPName, SalespersonNum, Commission FROM Salespeople;

--4
SELECT SalesPCity, SalesPName FROM Salespeople WHERE SalesPCity = 'London' AND Commission = .11;

--5
SELECT * FROM Customers WHERE NOT(Cusrating <= 100) OR CusCity = 'Rome';
--obviously could do Cusrating > 100 instead

--8
--It is including everyone, so:
SELECT SalesPCity, SalesPName, SalespersonNum, Commission FROM Salespeople;
UPDATE Salespeople SET Commission = NULL WHERE SALESPERSONNUM = 1001;
--a)
SELECT SalesPCity, SalesPName, SalespersonNum, Commission FROM Salespeople WHERE Commission IS NOT NULL;
--b)
SELECT SalesPCity, SalesPName, SalespersonNum, Commission FROM Salespeople;
ROLLBACK;

--9
SELECT * FROM Orders WHERE OrderDate IN ('03-OCT-2000', '04-OCT-2000');
SELECT * FROM Orders WHERE OrderDate = '03-OCT-2000' OR OrderDate =  '04-OCT-2000';

--10
SELECT * FROM Customers WHERE CusName >= 'A' AND CusName < 'H';
-- can also use substr to grab first letter and do a comparison, or other solutions

--11
SELECT * FROM Customers WHERE UPPER(CusName) LIKE 'C%';

--12
SELECT * FROM Orders WHERE OrderAmount > 0 AND OrderAmount IS NOT NULL;
SELECT * FROM Orders WHERE NVL(OrderAmount, 0) > 0;

--13
SELECT CustomerNum || ':' || TRIM(CusName) || '(' || NVL(CusRating, 0) || ')' AS CustInfo FROM Customers;

--14
SELECT TO_CHAR(OrderDate, 'Month yyyy') || ' $' || OrderAmount AS Amount FROM Orders;
SELECT TRIM(TO_CHAR(OrderDate, 'Month')) || ' ' || TO_CHAR(OrderDate, 'yyyy') || 
      ' $' || OrderAmount AS Amount FROM Orders;