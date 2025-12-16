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
--  Q1. Show all columns and rows.
SELECT * FROM Employees;
-- Q2. Show last name then first name (with aliases).
SELECT last_name AS "Last", first_name AS "First" FROM Employees;

-- Q3. Show emp_id, salary, and yearly salary (salary*12).

SELECT emp_id, salary, salary*12 AS annual_salary FROM Employees;
-- Q4. Make full names with concatenation.
SELECT first_name || ' ' || last_name AS full_name FROM Employees;

-- Q5. Show unique departments.
SELECT DISTINCT department FROM Employees;

SELECT emp_id, last_name, salary FROM Employees WHERE salary > 60000;
-- Q6. Employees in IT AND city Regina.

SELECT first_name, last_name FROM Employees WHERE department='IT' AND city='Regina';
-- Q7. Salaries BETWEEN 60000 AND 75000 (inclusive).
SELECT first_name, salary FROM Employees WHERE salary BETWEEN 60000 AND 75000;
--  Q8. Who has NULL salary? Who has NOT NULL commission?

SELECT first_name FROM Employees WHERE salary IS NULL;
SELECT first_name FROM Employees WHERE commission IS NOT NULL;
-- Q9. Departments IN ('IT','HR').

SELECT first_name, department FROM Employees WHERE department IN ('IT','HR');
-- Q10. Last names starting with 'S'.

SELECT first_name, last_name FROM Employees WHERE last_name LIKE 'S%';
-- Q11. Order by salary DESC (highest first), put NULLs last, then tie?break by last_name ASC.

SELECT last_name, first_name, salary FROM Employees
ORDER BY salary DESC NULLS LAST, last_name ASC;
--Q12.Cities (DISTINCT).
SELECT DISTINCT city FROM Employees;
-- Q13. Average salary by department (ignore NULL), only show avg >= 60000.

SELECT department, ROUND(AVG(salary)) AS avg_salary FROM Employees
GROUP BY department HAVING AVG(salary) >= 60000;




