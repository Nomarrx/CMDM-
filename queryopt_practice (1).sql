-- 1

EXPLAIN PLAN SET STATEMENT_ID = 'BigJoin' FOR
select aufname, aulname from author a join titleauthor ta on a.auid = ta.auid
  join title t on ta.titleid = t.titleid where t.title = 'Secrets of Silicon Valley';

EXPLAIN PLAN SET STATEMENT_ID = 'Nested' FOR
select aufname, aulname from author where auid IN 
    (select auid from titleauthor where titleid IN
        (select titleid from title where title = 'Secrets of Silicon Valley'));
		
--Join seems more efficient in this case less steps and lower cost


-- 2
EXPLAIN PLAN SET STATEMENT_ID = 'intersect' FOR
SELECT City FROM Author
INTERSECT
SELECT City FROM Publisher;

EXPLAIN PLAN SET STATEMENT_ID = 'joincity' FOR
SELECT DISTINCT A.City FROM Author A JOIN Publisher P ON A.city = P.City;

CREATE INDEX author_city_ind ON Author(city);
-- Rerun plans, change names

CREATE INDEX pub_city_ind ON Publisher(city);
-- Rerun plans, change names again

--Notice the huge difference the indexes made for the join (cost 8 vs cost 2)

-- 3a,b,c
EXPLAIN PLAN SET STATEMENT_ID = 'titlesort' FOR
SELECT Title, type, price FROM Title ORDER BY Title;
-- note that there is an index that is created in the BookBiz DB on Title
-- (see the creation script to look at it)
EXPLAIN PLAN SET STATEMENT_ID = 'typetitlesort' FOR
SELECT Title, type, price FROM Title ORDER BY Type, Title;

EXPLAIN PLAN SET STATEMENT_ID = 'pricetypetitlesort' FOR
SELECT Title, type, price FROM Title ORDER BY Price, Type, Title;

--seems no difference between last two

-- 3e
EXPLAIN PLAN SET STATEMENT_ID = 'pubtitlesort' FOR
SELECT Title, Pubname FROM Title T JOIN Publisher P ON T.pubid = P.pubid
ORDER BY title;

EXPLAIN PLAN SET STATEMENT_ID = 'pubtitlesort2' FOR
SELECT Title, Pubname FROM Title T JOIN Publisher P ON T.pubid = P.pubid
ORDER BY pubname;

EXPLAIN PLAN SET STATEMENT_ID = 'pubtitlesort3' FOR
SELECT Title, Pubname FROM Title T JOIN Publisher P ON T.pubid = P.pubid
ORDER BY title, pubname;

EXPLAIN PLAN SET STATEMENT_ID = 'pubtitlesort4' FOR
SELECT Title, Pubname FROM Title T JOIN Publisher P ON T.pubid = P.pubid
ORDER BY pubname, title;

-- Costs are the same - it is sorting on a non indexed field so they are all slow (Cost 7)