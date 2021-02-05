USE TestDB
GO




DECLARE PoductCursor1 CURSOR FOR
		SELECT ProductId, ProductName, Price
		FROM Product
		WHERE CategoryId = 1


OPEN PoductCursor1
DECLARE @ProductId int,
		@ProductName varchar(100),
		@Price money
FETCH NEXT FROM PoductCursor1 INTO @ProductId, @ProductName, @Price

WHILE @@FETCH_STATUS = 0
BEGIN
		
		IF @Price < 100
				UPDATE Product SET Price += 10
				WHERE ProductId = @ProductId

		FETCH NEXT FROM Product INTO @ProductId, @ProductName, @Price
END


CLOSE PoductCursor1

DEALLOCATE PoductCursor1
 