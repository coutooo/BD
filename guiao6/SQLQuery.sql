-- a)
SELECT * FROM authors;
-- b)
SELECT au_fname, au_lname, phone FROM authors;
-- c)
SELECT au_fname, au_lname, phone FROM authors ORDER BY au_fname, au_lname;
-- d)
SELECT au_fname AS first_name, au_lname AS last_name, phone AS telephone FROM authors ORDER BY au_fname, au_lname;
-- e)
SELECT au_fname AS first_name, au_lname AS last_name, phone AS telephone
FROM authors WHERE [state] = 'CA' AND au_lname != 'Ringer'
ORDER BY au_fname, au_lname;
-- f)
SELECT * FROM publishers WHERE pub_name LIKE '%Bo%';
-- g)
SELECT DISTINCT pub_name FROM (publishers JOIN titles ON publishers.pub_id=titles.pub_id) WHERE [type] = 'business';
-- h)
SELECT pub_name, SUM(ytd_sales) AS total_sales FROM (publishers JOIN titles ON publishers.pub_id=titles.pub_id) GROUP BY pub_name;
-- i)
SELECT pub_name, title, SUM(ytd_sales) AS total_sales FROM (publishers JOIN titles ON publishers.pub_id=titles.pub_id) GROUP BY pub_name, title;
-- j)
SELECT title FROM ((titles JOIN sales ON titles.title_id=sales.title_id) JOIN stores ON sales.stor_id=stores.stor_id)
WHERE stor_name = 'Bookbeat';
-- k)
SELECT au_fname AS first_name, au_lname AS last_name
FROM ((authors JOIN titleauthor ON authors.au_id=titleauthor.au_id) JOIN titles ON titleauthor.title_id=titles.title_id)
GROUP BY au_fname, au_lname HAVING COUNT([type]) > 1;
-- l)
SELECT pub_id, [type], AVG(price) AS average_price, SUM(ytd_sales) AS total_sales FROM titles
GROUP BY [type], pub_id;
-- m)
SELECT titles.[type] FROM (titles JOIN (SELECT [type], AVG(advance) AS average_advance FROM titles GROUP BY [type]) AS type_advance ON titles.[type]=type_advance.[type])
WHERE advance > 1.5 * average_advance;
-- n)
SELECT au_fname, au_lname, title, ((ytd_sales * price * royalty * royaltyper) / (100 * 100)) AS valor_arrecadado
FROM ((authors JOIN titleauthor ON authors.au_id=titleauthor.au_id)JOIN titles ON titles.title_id=titleauthor.title_id)
-- o)
SELECT title, ytd_sales, price * ytd_sales AS total_value, price * ytd_sales * royalty/100 AS author_value, price * ytd_sales * (100-royalty) / 100 AS publisher_value
FROM titles WHERE ytd_sales IS NOT NULL;
-- p)
SELECT ytd_sales, title, au_fname + ' ' + au_lname AS author_name, price * ytd_sales AS total_value, price * ytd_sales * royalty/100 AS author_value, price * ytd_sales * (100-royalty) / 100 AS publisher_value
FROM titles JOIN titleauthor ON titles.title_id=titleauthor.title_id JOIN authors ON titleauthor.au_id=authors.au_id
WHERE ytd_sales IS NOT NULL;
-- q)
SELECT stores.stor_id, stores.stor_name FROM (stores JOIN sales ON stores.stor_id=sales.stor_id) JOIN titles ON sales.title_id=titles.title_id
GROUP BY stores.stor_id, stores.stor_name HAVING COUNT(titles.title_id) >= (SELECT COUNT(*) FROM titles);
-- r)
SELECT stores.stor_id, stores.stor_name FROM stores JOIN sales ON stores.stor_id=sales.stor_id
GROUP BY stores.stor_id, stores.stor_name
HAVING SUM(qty) > (SELECT AVG(total_sales) FROM(
SELECT stor_name, SUM(qty) as total_sales
FROM stores JOIN sales ON stores.stor_id=sales.stor_id
GROUP BY stores.stor_id, stores.stor_name) AS store_sales);
-- s)
SELECT title FROM titles WHERE title_id NOT IN (SELECT title_id from sales LEFT JOIN stores ON sales.stor_id=stores.stor_id WHERE stor_name='Bookbeat');
-- t)
SELECT pub_name, stor_id FROM stores, publishers EXCEPT 
SELECT pub_name, stores.stor_id
FROM stores JOIN sales ON stores.stor_id=sales.stor_id JOIN titles ON sales.title_id=titles.title_id JOIN publishers ON titles.pub_id=publishers.pub_id
GROUP BY pub_name, stores.stor_id;