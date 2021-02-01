USE TestDB
GO

INSERT INTO Product (CategoryId, ProductName, Price)
VALUES (1, 'SSD', 110),
	   (1, 'HDD', 70),
	   (2, 'Case Phone', 25);

SELECT * FROM Product;

INSERT INTO Product (CategoryId, ProductName, Price)
 SELECT CategoryId, ProductName, Price
 FROM Product
 WHERE ProductId > 7 


 UPDATE Product SET Price = 72
 WHERE ProductName = 'HDD';


 SELECT * FROM Product;


 UPDATE Product SET ProductName = 'Test Tovar', Price = 999
 WHERE ProductId > 10;

SELECT * FROM Product
WHERE ProductId > 10;


UPDATE Product SET ProductName = Cp.CategoryName, Price = 200
FROM CategoryProduct AS Cp
INNER JOIN Product AS Pr ON Pr.CategoryId = Cp.CategoryId
WHERE Pr.ProductId > 10;

SELECT * FROM Product
WHERE ProductId > 10;

DELETE Product 
WHERE ProductId > 10;

SELECT * FROM Product;


CREATE TABLE TestTabForTrunc (
	idTest int NOT NULL IDENTITY(1,1),
	nameSport varchar(180) NOT NULL
);


INSERT INTO TestTabForTrunc (nameSport)
VALUES ('Football'),
	   ('BasketBall'),
	   ('Tenis'),
	   ('Ping-Pong');

SELECT * FROM TestTabForTrunc;

TRUNCATE TABLE TestTabForTrunc;

SELECT * FROM TestTabForTrunc;

CREATE TABLE Product2 (
	ProductId int NOT NULL,
	ProductName varchar(100) NOT NULL,
	Price MONEY NULL,
	CategoryId int NOT NULL
);

INSERT INTO Product2 (ProductId, ProductName, Price, CategoryId)
VALUES (1, 'Keyboard', 0, 1),
	   (2, 'Mouse', 0, 1),
	   (3, 'Test', 0, 1);


SELECT * FROM Product;
SELECT * FROM Product2;

MERGE Product2 AS T_SecondPr
	USING Product AS T_FirstPr
	ON (T_SecondPr.ProductId = T_FirstPr.ProductId)
	WHEN MATCHED THEN
			UPDATE SET ProductName = T_FirstPr.ProductName, 
			CategoryId = T_FirstPr.CategoryId, Price = T_FirstPr.Price
	WHEN NOT MATCHED THEN
			 INSERT (ProductId, ProductName, Price, CategoryId)
			 VALUES (T_FirstPr.ProductId, T_FirstPr.ProductName, T_FirstPr.Price, T_FirstPr.CategoryId)
	WHEN NOT MATCHED BY SOURCE THEN 
			 DELETE
	OUTPUT $action AS [Operation], Inserted.ProductId, Inserted.ProductName AS ProductNameNEW,
		   Inserted.Price AS PriceNEW,
		    Deleted.ProductName AS ProductNameOLD,
			Deleted.Price AS PriceOLD;

SELECT * FROM Product;
SELECT * FROM Product2;

INSERT INTO Product (ProductName, Price, CategoryId)
	OUTPUT inserted.ProductId,
		   inserted.ProductName,
		   inserted.Price,
		   inserted.CategoryId
	VALUES ('Test product 1', 300, 1),
		   ('Test product 2', 500, 2),
		   ('Test product 3', 400, 1);


UPDATE Product SET Price = 300
		OUTPUT inserted.ProductId AS [ProductId],
		deleted.Price AS [Old price],
		inserted.Price AS [New price]
WHERE ProductId > 3;

DELETE Product 
		OUTPUT deleted.*
WHERE ProductId > 10;

SELECT * FROM Product;