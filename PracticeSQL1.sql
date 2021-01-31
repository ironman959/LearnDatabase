DROP DATABASE somebase;
DROP DATABASE TestForVS;

CREATE DATABASE TestDB;


CREATE TABLE Product (
	ProductId int IDENTITY(1,1) NOT NULL,
	ProductName varchar(100) NOT NULL,
	Price money null,
	CategoryId int NOT NULL
);

Select * FROM Product;

CREATE TABLE CategoryProduct(
	CategoryId int IDENTITY(1,1) NOT NULL,
	CategoryName varchar(100) NOT NULL
);

Select * FROM CategoryProduct;

ALTER TABLE Product ADD Weight decimal(18,2) NULL;
ALTER TABLE Product ADD Summa AS (Weight * Price) PERSISTED;


-- Create test table for droping her
CREATE TABLE TestTableCategoryProduct(
	CategoryId int IDENTITY(1,1) NOT NULL,
	CategoryName varchar(100) NOT NULL
);

SELECT * FROM TestTableCategoryProduct;
DROP TABLE TestTableCategoryProduct;

ALTER TABLE Product ALTER COLUMN Price money NOT NULL;
ALTER TABLE Product DROP COLUMN Price;
ALTER TABLE Product ADD Price money NULL;


CREATE TABLE #TestTable (
	ProductId int IDENTITY(1,1) NOT NULL,
	ProductName varchar(100) NOT NULL,
	Price money null,
);

SELECT * FROM #TestTable;


INSERT INTO Product(ProductName, Price, CategoryId)
VALUES ('Keyboard', 100, 1),
	   ('Mouse', 50, 1),
	   ('Smartphone', 300, 2)

INSERT INTO CategoryProduct (CategoryName)
VALUES ('PC components'),
	   ('Mobile device');

SELECT ProductId, ProductName, Price 
FROM Product;

SELECT TOP 2 WITH TIES ProductId, ProductName, Price 
FROM Product
ORDER BY Price DESC;

SELECT TOP 20 PERCENT ProductId, ProductName, Price
FROM Product
ORDER BY Price DESC;

INSERT INTO Product (ProductName, Price, CategoryId)
VALUES ('Monitor', '300', 1);
INSERT INTO Product (ProductName, Price, CategoryId)
VALUES ('Headphones', 300, 2);
INSERT INTO Product (ProductName, Price, CategoryId)
VALUES ('Monitor', 100, 1);

SELECT DISTINCT ProductName, Price 
FROM Product;

SELECT * FROM TestDB.dbo.Product;


SELECT Pr.ProductId AS ID,
	   Pr.ProductName AS NAME,
	   Pr.Price AS PriceProduct
FROM Product AS Pr


SELECT ProductId, ProductName, Price
FROM Product
WHERE Price >= 100 OR Price < 100;

SELECT ProductId, ProductName, Price
FROM Product
WHERE ProductName LIKE 'S%';

SELECT ProductName, Price
FROM Product 
WHERE Price IN (50, 100);


SELECT ProductId, ProductName, Price
FROM Product
WHERE Price >= 100 AND Price <= 400;

SELECT ProductId, ProductName, Price
FROM Product
WHERE Price BETWEEN 100 AND 500
ORDER BY Price DESC;

SELECT ProductId, ProductName, Price
FROM Product
WHERE Price IS NOT NULL;

SELECT * FROM Product
WHERE Weight IS NULL;

SELECT COUNT(*) AS [Count String],
	   SUM(Price) AS [Sum column in Price],
	   MAX(Price) AS [Max value in column Price],
	   MIN(Price) AS [Min value in column Price],
	   AVG(Price) AS [Avg value in column Price]
FROM TestDB.dbo.Product;

USE TestDB;

SELECT CategoryId AS [Id category],
	   COUNT(*) AS [Count string],
	   MAX(Price) AS [Max value in column Price],
	   MIN(Price) AS [Min value in column Price],
	   AVG(Price) AS [Avg value in column Price]
FROM Product
GROUP BY CategoryId;


SELECT CategoryId AS [Id category],
	   COUNT(*) AS [Count string],
	   MAX(Price) AS [Max value in column Price],
	   MIN(Price) AS [Min value in column Price],
	   AVG(Price) AS [Avg value in column Price]
FROM Product
WHERE ProductId <> 2
GROUP BY CategoryId;


SELECT CategoryId AS [Id category],
	   COUNT(*) AS [Count string]
FROM Product
GROUP BY CategoryId
HAVING COUNT(*) > 1;

