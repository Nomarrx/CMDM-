
DROP TABLE Orders CASCADE CONSTRAINTS;
DROP TABLE Customers CASCADE CONSTRAINTS;
DROP TABLE Salespeople CASCADE CONSTRAINTS;


CREATE TABLE Salespeople (
  SalesPersonNum NUMBER(4) CONSTRAINT salesPeople_SalespersonNum_pk PRIMARY KEY,
  SalesPName VARCHAR2(15) CONSTRAINT salesPeople_PName_nn NOT NULL,
  SalesPCity VARCHAR2(15),
  Commission NUMBER(2, 2) DEFAULT .10
                          CONSTRAINT salespeople_comm_cc CHECK ((commission > 0) and
                                                (commission < 1)));

CREATE TABLE Customers (
  customernum NUMBER(4) CONSTRAINT customer_customer_pk PRIMARY KEY,
  cusName VARCHAR2(15) CONSTRAINT customer_name_nn NOT NULL,
  cusCity VARCHAR2(15),
  cusRating NUMBER(3),
  salesPersonNum NUMBER(4) CONSTRAINT customer_salesperson_fk REFERENCES SalesPeople(SalesPersonNum));
  
CREATE TABLE Orders (
  OrderNum NUMBER(4) CONSTRAINT orders_order_pk PRIMARY KEY,
  OrderAmount NUMBER(9, 2) CONSTRAINT orders_ordersamt_nn NOT NULL,
  OrderDate DATE constraint orders_orderdate_nn NOT NULL,
  SalesPersonNum NUMBER(4) CONSTRAINT orders_salesperson_fk REFERENCES SalesPeople(SalesPersonNum),
  customerNum NUMBER(4) CONSTRAINT orders_customer_fk REFERENCES Customers(customernum)
                        CONSTRAINT orders_customer_nn NOT NULL);
                        
                        

INSERT INTO Salespeople 
VALUES (1001, 'Peel', 'London', .12);

INSERT INTO Salespeople 
VALUES (1002, 'Serres', 'San Jose', .13);

INSERT INTO Salespeople 
VALUES (1004, 'Motika', 'London', .11);

INSERT INTO Salespeople 
VALUES (1007, 'Rifkin', 'Barcelona', .15);

INSERT INTO Salespeople 
VALUES (1003, 'Axelrod', 'New York', .10);


INSERT INTO Customers 
VALUES (2001, 'Hoffman', 'London', 100, 1001);

INSERT INTO Customers 
VALUES (2002, 'Giovanni', 'Rome', 200, 1003);

INSERT INTO Customers 
VALUES (2003, 'Liu', 'San Jose', 200, 1002);

INSERT INTO Customers 
VALUES (2004, 'Grass', 'Berlin', 300, 1002);



INSERT INTO Customers 
VALUES (2008, 'Cisneros', 'San Jose', 300, 1007);

INSERT INTO Customers 
VALUES (2007, 'Pereira', 'Rome', 100, 1004);

INSERT INTO Orders 
VALUES(3001, 18.69, TO_DATE('10/03/2000', 'MM/DD/YYYY'), 1007, 2008);



INSERT INTO Orders 
VALUES(3002, 1900.10, TO_DATE('10/03/2000', 'MM/DD/YYYY'), 1004, 2007);

INSERT INTO Orders 
VALUES(3005, 5160.45, TO_DATE('10/03/2000', 'MM/DD/YYYY'), 1002, 2003);

INSERT INTO Orders 
VALUES(3006, 1098.16, TO_DATE('10/03/2000', 'MM/DD/YYYY'), 1007, 2008);

INSERT INTO Orders 
VALUES(3009, 1713.23, TO_DATE('10/04/2000', 'MM/DD/YYYY'), 1003, 2002);

INSERT INTO Orders 
VALUES(3007, 75.75, TO_DATE('10/04/2000', 'MM/DD/YYYY'), 1002, 2004);



INSERT INTO Orders 
VALUES(3010, 1309.95, TO_DATE('10/06/2000', 'MM/DD/YYYY'), 1002, 2004);



COMMIT;

