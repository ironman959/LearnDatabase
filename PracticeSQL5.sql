USE TestDB
GO

DECLARE @TestVar int
SET @TestVar = 10
DECLARE @TestVar2 int
SELECT @TestVar2 = 20
DECLARE @TestVar3 int = 30
SELECT  ((@TestVar + @TestVar2) * @TestVar3) AS Result;


DECLARE @TestTable TABLE (
	 ProductId int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	 ProductName varchar(100) NOT NULL,
	 Price money DEFAULT (0) NOT NULL,
	 CategoryId int NOT NULL
); 

INSERT INTO @TestTable
	SELECT ProductName, Price, CategoryId
	FROM Product
	WHERE ProductId <=10;

SELECT * FROM @TestTable;



SELECT @@SERVERNAME AS [Name local server],
	   @@VERSION AS [Version SQL server];

--declare variable: count and summa
DECLARE @Cnt int, @Summa money

SET @Cnt = 10
SET @Summa = 150 

/*
	Execute operation multiplication.
	Example multistring comment.
*/

SELECT @Cnt * @Summa AS Result;

DECLARE @TestVar1 int
DECLARE @TestVar21 varchar(20)

SET @TestVar1  = 5

IF @TestVar1 > 0 
	SET @TestVar21 = 'More than 0'
ELSE 
	SET @TestVar21 = 'Less than 0'

SELECT @TestVar21 AS [Value TestVar1]



DECLARE @TestVar5 int
DECLARE @TestVar6 varchar(20)

SET @TestVar5 = 0 

IF @TestVar5 > 0 
	SET @TestVar6 = 'More than 0'
SELECT @TestVar6 AS [Value TestVar5]

DECLARE @Var1 int
DECLARE @Var2 varchar(20)

SET @Var1 = -5

IF @Var1 > 0 OR @Var1 = -5
	SET @Var2 = 'Correct value'

SELECT @Var2 AS [Value Var1];

DECLARE @CheckRec varchar(50)
IF EXISTS (SELECT * FROM Product)
	SET @CheckRec = 'Records are table product'
ELSE 
	SET @CheckRec = 'Records aren''t table product'

SELECT @CheckRec AS [Existence of records]


DECLARE @FirsVar int
DECLARE @SecondVar varchar(20)

SET @FirsVar = 2

SELECT @SecondVar = CASE @FirsVar WHEN 1 THEN 'Number one'
							      WHEN 2 THEN 'Number two'
								  ELSE 'Unknown'
					END
SELECT @SecondVar AS [Number];


DECLARE @Var01 int
DECLARE @Var02 varchar(20), @Var03 varchar(20), @VarErr varchar(20)

SET @Var01 = 1

IF @Var01 NOT IN (0, 1, 2)
BEGIN
	SET @Var02 = 'First Instruction'
	SET @Var03 = 'Second Instruction'
END 
ELSE 
	SET @VarErr = 'Value is false'

SELECT @Var02 AS [Value Var01],
	   @Var03 AS [Value Var02],
	   @VarErr AS [Value Var01 is conditional else]


DECLARE @CountAll int = 0

--start cycle
WHILE @CountAll  < 10 
BEGIN 
	SET @CountAll += 1
	IF @CountAll = 5
		BREAK
END

SELECT @CountAll AS result;


DECLARE @Count int = 0
DECLARE @CountAl int = 0

WHILE @CountAl < 10
BEGIN
	SET @CountAl += 1

	IF @CountAl = 5
		CONTINUE

	SET @Count += 1
END
SELECT @CountAl AS [CountAll],
@Count AS [Count];


DECLARE @Var21 int = 1

IF @Var21 > 0 
	PRINT 'Value variable more than 0'
ELSE
	PRINT 'Value variable less or equal 0'


DECLARE @VarR int = 1
IF @VarR < 0 
	RETURN

SELECT @VarR AS [result];


DECLARE @Varx int = 0

METKA:

SET @Varx += 1

IF @Varx < 10
	GOTO METKA
SELECT @Varx AS [result];


DECLARE @VarTest int = 2
DECLARE @Rez int = 0

IF @VarTest <= 0
    GOTO METKA
SET @Rez = 10 / @VarTest

METKA:

SELECT @Rez AS [result];


WAITFOR DELAY '00:00:05'
	SELECT 'Continue executing instruction' AS [Test];

WAITFOR TIME '00:00:05'
	SELECT 'Continue executing instruction' AS [Test];


BEGIN TRY 
	DECLARE @TestVar11 int = 10,
			@TestVar22 int = 0,
			@Rez1 int
	SET @Rez1 = @TestVar11 / @TestVar22
END TRY

BEGIN CATCH 
	SELECT ERROR_NUMBER() AS [Number error],
		   ERROR_MESSAGE() AS [Description error]
	SET @Rez1 = 0
END CATCH

SELECT @Rez1 AS [Result];