USE TestDB
GO

 SELECT ProductId, ProductName, Price
 FROM Product
 ORDER BY Price;

 SELECT ProductId, ProductName, Price
 FROM Product
 ORDER BY Price DESC;

SELECT ProductId, ProductName, Price
FROM Product
ORDER BY Price DESC, ProductName;

 SELECT ProductId, ProductName, Price
 FROM Product
 ORDER BY 3 DESC, 1;

 SELECT ProductId, ProductName, Price
 FROM Product
 ORDER BY Price DESC
 OFFSET 1 ROWS;

 SELECT ProductId, ProductName, Price
 FROM Product
 ORDER BY Price DESC, ProductName
 OFFSET 1 ROWS;

 SELECT ProductId, ProductName, Price
 FROM Product 
 ORDER BY Price DESC
 OFFSET 1 ROWS FETCH NEXT 3 ROWS ONLY;

 
 SELECT Pr.ProductName, CategoryProduct.CategoryId, Pr.Price
 FROM Product AS Pr
 INNER JOIN CategoryProduct ON Pr.CategoryId = CategoryProduct.CategoryId
 ORDER BY Pr.CategoryId;

 SELECT Pr.ProductName, CategoryProduct.CategoryName, Pr.Price
 FROM Product AS Pr
 INNER JOIN CategoryProduct ON Pr.CategoryId = CategoryProduct.CategoryId
 ORDER BY Pr.CategoryId;

 SELECT Pr.ProductName, CategoryProduct.CategoryName, Price
 FROM Product AS Pr
 LEFT JOIN CategoryProduct ON Pr.CategoryId = CategoryProduct.CategoryId
 ORDER BY Pr.CategoryId;


 SELECT Pr.ProductName, CategoryProduct.CategoryName, Pr.Price
 FROM Product AS Pr
 INNER JOIN CategoryProduct ON Pr.CategoryId = 5
 ORDER BY Pr.CategoryId;


 SELECT Pr.ProductName, CategoryProduct.CategoryId, Pr.Price
 FROM Product AS Pr
 LEFT OUTER JOIN CategoryProduct ON Pr.CategoryId = 3
 ORDER BY Pr.CategoryId;

SELECT  Pr.ProductName, Cp.CategoryId, Pr.Price
FROM Product AS Pr
RIGHT JOIN CategoryProduct AS Cp ON Pr.CategoryId = Cp.CategoryId
ORDER BY Pr.CategoryId;

SELECT Pr.ProductName, Cp.CategoryId, Pr.Price
FROM Product AS Pr
RIGHT JOIN CategoryProduct AS CP ON Pr.CategoryId = 9;

SELECT Pr.ProductName, Cp.CategoryId, Pr.Price
FROM Product AS Pr
FULL JOIN CategoryProduct AS Cp ON Pr.CategoryId = Cp.CategoryId
ORDER BY Pr.CategoryId;

SELECT Pr.ProductName, Cp.CategoryId, Pr.Price
FROM Product AS Pr
FULL JOIN CategoryProduct AS Cp ON Pr.CategoryId = 5
ORDER BY Pr.CategoryId;

SELECT Pr.ProductName, Cp.CategoryName, Pr.Price
FROM Product AS Pr
CROSS JOIN CategoryProduct AS Cp
ORDER BY Pr.CategoryId;


SELECT Pr.ProductName, Cp.CategoryName, Pr.Price
FROM Product AS Pr
CROSS JOIN CategoryProduct AS Cp
WHERE Pr.CategoryId = Cp.CategoryId
ORDER BY Pr.CategoryId;


SELECT Pr.ProductId, Pr.ProductName, Pr.Price
FROM Product AS Pr
WHERE Pr.ProductId = 2

UNION

SELECT Pr.ProductId, Pr.ProductName, Pr.Price
FROM Product AS Pr
WHERE Pr.ProductId = 5;


SELECT Pr.ProductId, Pr.ProductName, Pr.Price
FROM Product AS Pr
WHERE Pr.ProductId = 2

UNION

SELECT Pr.ProductId, Pr.ProductName, Pr.Price
FROM Product AS Pr
WHERE Pr.ProductId = 2;


SELECT Pr.ProductId, Pr.ProductName, Pr.Price
FROM Product AS Pr
WHERE Pr.ProductId = 2

UNION ALL

SELECT Pr.ProductId, Pr.ProductName, Pr.Price
FROM Product AS Pr
WHERE Pr.ProductId = 2;

SELECT Pr.ProductId, Pr.ProductName, Pr.Price
FROM Product AS Pr
WHERE Pr.ProductId = 4

UNION ALL

SELECT Pr.ProductId, Pr.ProductName, Pr.Price
FROM Product AS Pr
WHERE Pr.ProductId = 5
ORDER BY Pr.ProductName;



SELECT Pr.ProductId, Pr.ProductName, Pr.Price
FROM Product AS Pr
WHERE Pr.ProductId = 6

INTERSECT 

SELECT Pr.ProductId, Pr.ProductName, Pr.Price
FROM Product AS Pr
WHERE Pr.ProductId = 6

--Not output uniqe value
SELECT Pr.ProductId, Pr.ProductName, Pr.Price
FROM Product AS Pr
WHERE Pr.ProductId = 6

INTERSECT 

SELECT Pr.ProductId, Pr.ProductName, Pr.Price
FROM Product AS Pr
WHERE Pr.ProductId = 5;

--Output first string because this string not a secong query
SELECT Pr.ProductId, Pr.ProductName, Pr.Price
FROM Product AS Pr
WHERE Pr.ProductId = 5

EXCEPT 

SELECT Pr.ProductId, Pr.ProductName, Pr.Price
FROM Product AS Pr
WHERE Pr.ProductId = 7;


SELECT Pr.ProductId, Pr.ProductName, Pr.Price
FROM Product AS Pr
WHERE Pr.ProductId = 5

EXCEPT 

SELECT Pr.ProductId, Pr.ProductName, Pr.Price
FROM Product AS Pr
WHERE Pr.ProductId = 5;

SELECT Cp.CategoryName AS [Name category],
		(SELECT COUNT(*)
		 FROM Product
		 WHERE CategoryId = Cp.CategoryId) AS [Quantity product]
FROM CategoryProduct AS Cp;


SELECT Q1.ProductId, Q1.Price, Q2.CategoryName
FROM (SELECT ProductId, Price, CategoryId
	   FROM Product) AS Q1
LEFT JOIN (SELECT CategoryId, CategoryName FROM CategoryProduct) AS Q2 ON Q1.CategoryId = Q2.CategoryId;

CREATE VIEW ViewCountProducts 
AS 
	SELECT Cp.CategoryName AS [Name category],
	(SELECT COUNT(*)
	 FROM Product
	 WHERE CategoryId = Cp.CategoryId) AS [Quantity product]
	 FROM  CategoryProduct AS Cp;

SELECT * FROM ViewCountProducts;

ALTER VIEW  ViewCountProducts 
AS
	SELECT Cp.CategoryName AS [Name category],
	Cp.CategoryId AS CategoryID,
	(SELECT COUNT(*)
	 FROM Product
	 WHERE CategoryId = Cp.CategoryId) AS [Quantity product]
	 FROM  CategoryProduct AS Cp;

SELECT * FROM ViewCountProducts;

DROP VIEW ViewCountProducts;

SELECT * FROM sys.tables;

SELECT * FROM sys.columns
WHERE object_id  = object_id('Product');