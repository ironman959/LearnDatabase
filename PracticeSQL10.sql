USE TestDB
GO


WITH ProductCTE (ProductId, ProductName, Price) AS
	 (
					SELECT ProductId, ProductName, Price
					FROM Product
					WHERE CategoryId  = 1
	 )
SELECT * FROM ProductCTE;


WITH ProductCTE12 AS 
		(
			SELECT ProductId, CategoryId, ProductName, Price
			FROM ProductCTE12
		), ProductCTE21 AS
		(
			SELECT CategoryId, CategoryName
			FROM CategoryProduct
		)

SELECT Pc.ProductName, Pc2.CategoryName, Pc.Price
FROM ProductCTE12 AS Pc
LEFT JOIN ProductCTE21 AS Pc2 ON Pc.CategoryId = Pc2.CategoryId
WHERE Pc.CategoryId  = 1 

