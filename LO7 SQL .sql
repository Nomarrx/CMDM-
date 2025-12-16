--LO7 Views

-- Write a query to display the names of authors (aufname, aulname) 
--who live in Oakland CA and their books (titleid, title)
SELECT auFName, auLName, t.titleid, title
FROM Author A JOIN TitleAuthor TA ON A.auid = TA.auid
              JOIN Title T ON TA.titleid = T.titleID
WHERE city = 'Oakland' AND state = 'CA';

--Make a view out of it:
CREATE OR REPLACE VIEW Oaklander (fname, lname, tid, title) AS
SELECT auFName, auLName, t.titleid, title
FROM Author A JOIN TitleAuthor TA ON A.auid = TA.auid
              JOIN Title T ON TA.titleid = T.titleID
WHERE city = 'Oakland' AND state = 'CA';

--using the view:
SELECT * FROM Oaklander;
SELECT * FROM Oaklander ORDER BY title;

--Use the view to show the author's last name for authors with more than 1 book.
SELECT lname, COUNT(*) FROM Oaklander GROUP BY LName HAVING COUNT(*) > 1;

-- Changing data through a view
CREATE OR REPLACE VIEW HighPrice AS
  SELECT * FROM title WHERE price > 15 AND advance > 5000;
  
SELECT * FROM HighPrice;
UPDATE HighPrice SET price = 10 WHERE titleID = 'PC8888';
-- no longer visible by view:
SELECT * FROM HighPrice;
SELECT * FROM Title;

-- the WITH CHECK OPTION prevents updates from "hiding" rows from the view
CREATE OR REPLACE VIEW HighPrice AS
  SELECT * FROM title WHERE price > 15 AND advance > 5000
WITH CHECK OPTION;
SELECT * FROM HighPrice;
UPDATE HighPrice SET price = 10 WHERE titleID = 'TC7777';

--Deleting views:
DROP VIEW Oaklander;
DROP VIEW HighPrice;

--Determining the updateability of views

--Query with multiple tables:
CREATE OR REPLACE VIEW RoyaltyAmt AS
SELECT a.auid, aulname, aufname, royaltyshare, t.titleid, title, price, royalty, price * royalty * royaltyshare AS amount
FROM Author A JOIN TitleAuthor TA ON A.auid = TA.auid JOIN Title T ON T.titleID = TA.titleid
            JOIN RoySched R ON t.titleid = r.titleid;

SELECT * FROM RoyaltyAmt;
--Can we make changes?
DELETE FROM RoyaltyAmt;
--No - there isn't just one key preserved table

--Another example:
CREATE VIEW CurrentInfo AS
  SELECT p.pubid, pubname, SUM(ytdsales) AS revenue, AVG(ytdsales) AS avgsales
    FROM Publisher P JOIN Title T ON P.pubid = T.pubid
    GROUP BY p.pubid, p.pubname;

SELECT * FROM CurrentInfo;
--Both changes below do not work. Aggregates and grouping prevent updates to the view
DELETE FROM CurrentInfo;
UPDATE CurrentInfo SET pubname = 'AAA';

--View on a single table:
CREATE OR REPLACE VIEW V1 AS
  SELECT aulname, aufname, phone
  FROM Author WHERE zip LIKE '94%';

SELECT * FROM V1;
--Key preserved table is author (only table in view, no grouping, aggregates, etc.)
--INSERT, UPDATE, DELETE?
UPDATE V1 SET aufname = 'Abe' WHERE aufname = 'Abraham';
--Updates are allowed on the columns visible by the view. Below won't work:
UPDATE V1 SET city = 'Saskatoon' WHERE aufname = 'Abraham';
--Deletes:
DELETE FROM V1; 
-- Deletes do work, but referential integrity is still enforced, can't delete parent records with children
--Inserts:
INSERT INTO V1 VALUES ('Schmidt', 'Jason', '94444');
--Not all of the NOT NULL / PK columns are in the view, we can't insert using it

--Create a based on another view:
CREATE OR REPLACE VIEW V2 AS
  SELECT aulname, phone FROM V1 WHERE aulname > 'M';
--Updateable? Yes, author is still key preserved
SELECT * FROM V2;
DELETE FROM V2; -- works, again referential integrity still in place
--Inserts still don't work - missing PK
--Updates can be done on the two columns

--Another layer:
CREATE OR REPLACE VIEW V3 AS
  SELECT aulname, phone, 'Another View' AS Expression FROM V2 WHERE aulname = 'MacFeather';
SELECT * FROM V3;
UPDATE V3 SET phone = '1234', Expression = 'Hello'; -- can't change the calculated field

--Make a change to V2
CREATE OR REPLACE VIEW V2 AS
  SELECT aulname, phone FROM V1 WHERE aulname > 'M' AND phone LIKE '408%';
--Will affect V3's data set:
SELECT * FROM V3;

--Analyzing Views Exercise:
CREATE OR REPLACE VIEW Oaklanders
AS
SELECT auFName AS First, auLName AS Last, t.titleID, title
FROM Author a JOIN TitleAuthor ta ON a.auID = ta.auID
	JOIN Title t ON ta.titleID = t.titleID
WHERE city = 'Oakland'
	AND state = 'CA';

SELECT * FROM Oaklanders;
DELETE FROM Oaklanders WHERE titleid = 'BU1032';
INSERT INTO Oaklanders VALUES ('Jason', 'Schmidt', 'BU1032', 'Title');

--Change to map titleid to TitleAuthor:
CREATE OR REPLACE VIEW Oaklanders
AS
SELECT auFName AS First, auLName AS Last, ta.titleID, title
FROM Author a JOIN TitleAuthor ta ON a.auID = ta.auID
	JOIN Title t ON ta.titleID = t.titleID
WHERE city = 'Oakland'
	AND state = 'CA';

SELECT * FROM Oaklanders;
DELETE FROM Oaklanders WHERE titleid = 'BU2075';
ROLLBACK;
UPDATE Oaklanders SET titleID = 'BU1032' WHERE titleid = 'BU2075';
--update above is still failing, but it is because of an integrity constraint
DESC TitleAuthor;

--#3
CREATE OR REPLACE VIEW Oaklanders
AS
SELECT ta.auID, auFName AS First, auLName AS Last, ta.titleID, title, ta.auOrder
FROM Author a JOIN TitleAuthor ta ON a.auID = ta.auID
	JOIN Title t ON ta.titleID = t.titleID
WHERE city = 'Oakland'
	AND state = 'CA';

SELECT * FROM OAKLANDERS;
INSERT INTO Oaklanders (auID, titleID, auOrder)
VALUES ('213-46-8915', 'BU1111', 3);
ROLLBACK;
--	UPDATE
UPDATE Oaklanders
SET titleID = 'BU7832', auorder = 4
WHERE titleID = 'BU1032';
ROLLBACK;
--	Delete statement
DELETE FROM Oaklanders
WHERE titleID = 'BU1032';
ROLLBACK;

--#4
CREATE OR REPLACE VIEW CompleteBookInfo
AS
SELECT a.auID, auLName AS AuthorLast, auOrder, t.titleID, title, e.edID, edLName AS EditorLast, edOrder
FROM Author a JOIN TitleAuthor ta ON a.auID = ta.auID
	JOIN Title t ON ta.titleID = t.titleID
	JOIN TitleEditor te ON t.titleID = te.titleID
	JOIN Editor e ON te.edID = e.edID;

SELECT * FROM CompleteBookInfo;
DELETE FROM CompleteBookInfo;
UPDATE CompleteBookInfo SET auorder = 5 WHERE titleID = 'BU1032';
UPDATE CompleteBookInfo SET edorder = 5 WHERE titleID = 'BU1032';