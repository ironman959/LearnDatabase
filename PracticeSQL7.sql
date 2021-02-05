USE TestDB
GO

CREATE PROCEDURE CategoryProcedure 
(
	@CategoryId int,
	@ProductName varchar(100)
)
AS
BEGIN
		DECLARE @AVG_Price money

		SELECT @AVG_Price = ROUND(AVG(Price), 2)
		FROM Product
		WHERE @CategoryId = CategoryId

		INSERT iNTO Product(CategoryId, ProductName, Price)
		VALUES(@CategoryId, LTRIM(RTRIM(@ProductName)), @AVG_Price)


		SELECT * FROM Product
		WHERE CategoryId = @CategoryId
END

GO


EXEC CategoryProcedure @CategoryId = 1, @ProductName = 'CPU'


ALTER PROCEDURE CategoryProcedure 
(
	@CategoryId int,
	@ProductName varchar(100),
	@Price money
)
AS 
BEGIN
		IF @Price IS NULL
				 SELECT @Price = ROUND(AVG(Price), 2)
				 FROM Product
				 WHERE CategoryId = @CategoryId


		INSERT iNTO Product(CategoryId, ProductName, Price)
		VALUES(@CategoryId, LTRIM(RTRIM(@ProductName)), @Price)


		SELECT * FROM Product
		WHERE CategoryId = @CategoryId
		
END

GO

EXECUTE CategoryProcedure @CategoryId = 1,
					      @ProductName = 'VideoCard',
						  @Price = 550;

DROP PROCEDURE CategoryProcedure;


EXEC sp_helpdb 'TestDB';


EXEC sp_tables @table_type = "'TABLE'";

EXEC  sp_rename Product2, ProductTest;

CREATE TABLE AuditProduct1 (
	idAudit1 int IDENTITY(1, 1) NOT NULL,
	dataChange DATETIME NOT NULL,
	UserName varchar(100) NOT NULL,
	SQL_Command varchar(100) NOT NULL,
	ProductId_Old int NULL,
	ProductId_New int NULL,
	CategoryId_Old int NULL,
	CategoryId_New int NULL,
	ProductName_Old varchar(100) NULL,
	ProductName_New varchar(100) NULL,
	Price_Old money NULL,
	Price_New money NULL,
	CONSTRAINT PK_AuditProduct1 PRIMARY KEY (IdAudit1)
);

CREATE TRIGGER TRG_Audit_Product3 ON Product
		AFTER INSERT, UPDATE, DELETE
AS 
BEGIN
		DECLARE @SQL_Command varchar(100);

		IF EXISTS (SELECT * FROM inserted) AND NOT EXISTS (SELECT * FROM deleted) SET @SQL_Command = 'INSERT' 
		IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted) SET @SQL_Command = 'UPDATE' 
		IF NOT EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted) SET @SQL_Command = 'DELETE'

		
		IF @SQL_Command = 'UPDATE' OR @SQL_Command = 'INSERT' 
		BEGIN 
		     INSERT INTO AuditProduct1(dataChange, UserName, SQL_Command, ProductId_Old, ProductId_New, CategoryId_Old, CategoryId_New, ProductName_Old, ProductName_New, Price_Old, Price_New) 
		      SELECT GETDATE(), SUSER_SNAME(), @SQL_Command, D.ProductId, I.ProductId, D.CategoryId, I.CategoryId, D.ProductName, I.ProductName, D.Price, I.Price 
		     FROM inserted I 
		LEFT JOIN deleted D ON I.ProductId = D.ProductId 
		END 

		
		IF @SQL_Command = 'DELETE' 
		BEGIN 
				INSERT INTO AuditProduct1(dataChange, UserName, SQL_Command, ProductId_Old, ProductId_New, CategoryId_Old, CategoryId_New, ProductName_Old, ProductName_New, Price_Old, Price_New) 
							SELECT GETDATE(), SUSER_SNAME(), @SQL_Command, D.ProductId, NULL, D.CategoryId, NULL, D.ProductName, NULL, D.Price, NULL FROM deleted D
	    END 
END

INSERT INTO Product(CategoryId, ProductName, Price)
VALUES(1, 'Laptop', 0);

UPDATE Product SET Price = 901
WHERE ProductName = 'Laptop';

DELETE Product WHERE Price = '901'
DELETE Product WHERE ProductId = 36
SELECT * FROM Product
SELECT * FROM AuditProductTable

DISABLE TRIGGER TRG_Audit_Product3 ON Product;
ENABLE  TRIGGER TRG_Audit_Product3 ON Product;

ALTER TRIGGER TRG_Audit_Product3 ON Product
		AFTER INSERT, UPDATE, DELETE
AS 
BEGIN
		DECLARE @SQL_Command varchar(100);

		IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted) 
		           SET @SQL_Command = 'UPDATE'
		ELSE
		     SET @SQL_Command = 'INSERT'

		
		 
	
		INSERT INTO AuditProduct1(dataChange, UserName, SQL_Command, ProductId_Old, ProductId_New, CategoryId_Old, CategoryId_New, ProductName_Old, ProductName_New, Price_Old, Price_New) 
		SELECT GETDATE(), SUSER_SNAME(), @SQL_Command, D.ProductId, I.ProductId, D.CategoryId, I.CategoryId, D.ProductName, I.ProductName, D.Price, I.Price 
		FROM inserted I 
		LEFT JOIN deleted D ON I.ProductId = D.ProductId 
		
END


DROP TRIGGER TRG_Audit_Product;
DROP TRIGGER TRG_Audit_Product1;
DROP TRIGGER TRG_Audit_Product12;
DROP TRIGGER TRG_Audit_Product2;
DROP TRIGGER TRG_Audit_Product21;
DROP TRIGGER TRG_Audit_Product22;
DROP TRIGGER TRG_Audit_ProductTable;