DROP TABLE Employee CASCADE CONSTRAINTS;
CREATE TABLE Employees (
  emp_id       NUMBER(6)      PRIMARY KEY,
  first_name   VARCHAR2(20),
  last_name    VARCHAR2(20),
  department   VARCHAR2(20),
  city         VARCHAR2(30),
  salary       NUMBER(8),
  commission   NUMBER(8),
  hire_date    DATE,
  middle_name  VARCHAR2(20),
  promo_code   VARCHAR2(20)
);
-- Insert sample rows
INSERT INTO Employees VALUES (101, 'John', 'Smith',  'IT',      'Regina',     70000,   NULL,   DATE '2022-05-10', NULL, '50%SALE');
INSERT INTO Employees VALUES (102, 'Jane', 'Doe',    'HR',      'Saskatoon',  55000,   NULL,   DATE '2023-01-15', 'A.', 'A_23');
INSERT INTO Employees VALUES (103, 'Raj',  'Simon',  'IT',      'Regina',     80000,   5000,   DATE '2021-09-01', NULL, NULL);
INSERT INTO Employees VALUES (104, 'Mia',  'Chen',   'Finance', 'Moose Jaw',  62000,   NULL,   DATE '2024-03-20', NULL, 'SAVE10');
INSERT INTO Employees VALUES (105, 'Sam',  'Wilson', 'IT',      'Regina',     NULL,    NULL,   DATE '2020-12-12', NULL, '50%OFF');

COMMIT;