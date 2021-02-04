USE TestDB;

CREATE FUNCTION ProductFunction 
	(
			@ProductId int
	)
	RETURNS varchar(100)
	AS 
	BEGIN
			DECLARE @ProductName varchar(100);

			SELECT @ProductName = ProductName
			FROM Product
			WHERE ProductId = @ProductId

			RETURN @ProductName
	END
	GO

SELECT dbo.ProductFunction(3) AS [Name product];


SELECT ProductId,
	   ProductName,
	   dbo.ProductFunction(ProductId) AS [Name product]
FROM Product 
ORDER BY ProductId ASC;



CREATE FUNCTION FC_CategoryFunction 
	(
		@CategoryId int
	)
	RETURNS TABLE
	AS 
	RETURN (
			
			SELECT ProductId,
				   ProductName,
				   Price,
				   CategoryId
			FROM Product
			WHERE CategoryId = @CategoryId
	)
	GO

SELECT * FROM FC_CategoryFunction(1);

SELECT * FROM FC_CategoryFunction(2);


CREATE FUNCTION FC_CategoryFunction2
	(
		@CategoryId int,
		@Price money
	)

	RETURNS @TMPTable TABLE (ProductId int,
							 ProductName varchar(100),
							 Price money,
							 CategoryId int
							 )
	AS
	BEGIN

			IF @Price < 0
				SET @Price = 0

			INSERT INTO @TMPTable
				SELECT ProductId,
					   ProductName,
					   Price,
					   CategoryId
				FROM Product
				WHERE CategoryId = @CategoryId
				  AND Price <= @Price

				  RETURN
	END

	GO 

SELECT * FROM FC_CategoryFunction2(2, 300);


ALTER FUNCTION ProductFunction 
	 (
		@ProductId int
	 )
		
	RETURNS varchar(100)
	AS 
	BEGIN 
			DECLARE @CategoryName varchar(100);

			SELECT @CategoryName = Cp.CategoryName
			FROM Product AS Pr
			INNER JOIN CategoryProduct AS Cp ON Pr.CategoryId = Cp.CategoryId
			WHERE Pr.ProductId = @ProductId

			RETURN @CategoryName

	END
	GO


SELECT ProductId,
	   ProductName,
	   dbo.ProductFunction(ProductId) AS [CategoryName]
FROM Product
ORDER BY ProductId ASC;


DROP FUNCTION FC_CategoryFunction2;


DECLARE @Var1 varchar(200) = '               TEXT',
		@Var2 varchar(200) = 'TEXT               '

SELECT @Var1 AS Variable1,
       @Var2 AS Variable2


SELECT LTRIM(@Var1) AS Variable1,
	   RTRIM(@Var2) AS Variable2



DECLARE @VarUpper varchar(100),
	    @VarLower varchar(100)

SELECT @VarUpper = 'text',
	   @VarLower = 'TEXT'


SELECT @VarUpper AS [Upper],
	   @VarLower AS [Lower]

SELECT UPPER(@VarUpper) AS [word in upper case],
	   LOWER(@VarLower) As [word in lower case] 


SELECT LEN('misha') AS [Count chars];

DECLARE @VariableL varchar(100),
		@VariableR varchar(100)

SELECT @VariableL = '1234567890',
	   @VariableR = '1234567890'

SELECT LEFT(@VariableL, 5) AS FirstFive,
	   RIGHT(@VariableR, 5) AS LastFive;


DECLARE @VarSub varchar(100)

SELECT @VarSub = '1234567890'

SELECT SUBSTRING(@VarSub, 4, 5) AS Substirng;

DECLARE @VarDate DATETIME 

SET @VarDate = GETDATE()

SELECT GETDATE() AS [Current date],
	   DATENAME(M, @VarDate) AS [Name month],
	   DATEPART(M, @VarDate) AS [Number month],
	   DAY(@VarDate) AS [Day],
	   MONTH(@VarDate) AS [Month],
	   YEAR(@VarDate) AS [Year],
	   DATEDIFF(D, '11.19.2020', @VarDate) AS [Count days],
	   DATEADD(D, 19, GETDATE()) AS [Plus 19 days];


SELECT ABS(-100) AS [ABS],
	   ROUND(1.589, 2) AS [ROUND],
	   CEILING(1.7) AS [CEILING],
	   FLOOR(1.7) AS [FLOOR],
	   SQRT(16) AS [SQRT],
	   SQUARE(4) AS [SQUARE],
	   POWER(4, 2) AS [POWER],
	   LOG(1000) AS [LOG];

SELECT DB_ID() AS [ID current],
	   DB_NAME() AS [Name current BD],
	   OBJECT_ID('Product') AS [Identification table Product],
	   OBJECT_NAME(149575571) AS [Name object with id];

SELECT ISNULL(NULL, 5) AS [ISNULL],
	   COALESCE(NULL, NULL, 5) AS [COALESCE],
	   CAST(1.5 AS int) AS [CAST],
	   HOST_NAME() AS [HOST_NAME],
	   SUSER_NAME() AS [SUSER_NAME],
	   USER_NAME() AS [USER_NAME];