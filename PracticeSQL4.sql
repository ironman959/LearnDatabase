USE TestDB;


CREATE UNIQUE CLUSTERED INDEX IX_Clustered ON Product 
(
	ProductId ASC
);

CREATE NONCLUSTERED INDEX IX_NonClustered ON Product 
(
	CategoryId ASC
);


DROP INDEX IX_NonClustered ON Product;

 CREATE NONCLUSTERED INDEX IX_NonClustered ON Product
 (
	CategoryId ASC,
	ProductName ASC
 )
	INCLUDE (Price);


CREATE NONCLUSTERED INDEX IX_NonClustered ON Product
 (
	CategoryId ASC,
	ProductName ASC
 )
	INCLUDE (Price)
WITH (DROP_EXISTING = ON);

SELECT OBJECT_NAME(T1.object_id) AS NameTable, 
T1.index_id AS IndexId, 
T2.name AS IndexName, 
T1.avg_fragmentation_in_percent AS Fragmentation FROM sys.dm_db_index_physical_stats (DB_ID(), NULL, NULL, NULL, NULL)
AS T1 
LEFT JOIN sys.indexes AS T2 ON T1.object_id = T2.object_id AND T1.index_id = T2.index_id

ALTER INDEX IX_NonClustered ON Product
REORGANIZE;

ALTER INDEX IX_NonClustered ON Product
REBUILD;

ALTER TABLE Product ALTER COLUMN Price money NOT NULL;

CREATE TABLE TestCategory1 (
	CategoryId int IDENTITY(1,1) NOT NULL CONSTRAINT PK_CategoryId PRIMARY KEY,
	CategoryName varchar(100) NOT NULL
);


CREATE TABLE TestCategory2(
	CategoryaId int IDENTITY(1,1) NOT NULL,
	CategoryName varchar(100) NOT NULL,
	CONSTRAINT PK_CategoryaId PRIMARY KEY (CategoryaId)
);

ALTER TABLE Product ADD CONSTRAINT PK_ProductID PRIMARY KEY (ProductId);
ALTER TABLE Product  DROP CONSTRAINT PK_ProductID; 
ALTER TABLE Product ADD CONSTRAINT PR_Product PRIMARY KEY (ProductId);


CREATE TABLE TestProduct5 (
	ProductId int IDENTITY(1,1) NOT NULL,
	ProductName varchar(100) NOT NULL,
	Price money DEFAULT 0 NOT NULL,
	CategoryId int NOT NULL,
	CONSTRAINT PK_TestProduct5 PRIMARY KEY (ProductId),
	CONSTRAINT FK_TestProduct5 FOREIGN KEY (CategoryId) REFERENCES TestCategory1 (CategoryId)
		ON DELETE CASCADE 
		ON UPDATE NO ACTION 
);

SELECT * FROM sys.key_constraints;

ALTER TABLE CategoryProduct ADD CONSTRAINT PK_CategoryProduct PRIMARY KEY (CategoryId);

ALTER TABLE Product ADD CONSTRAINT FK_Product FOREIGN KEY (CategoryId) REFERENCES CategoryProduct (CategoryId);

CREATE TABLE TestTable5 (
		Column1 int NOT NULL CONSTRAINT PK_TestTable5_C1 UNIQUE,
		Column2 int NOT NULL,
		Column3 int NOT NULL,
		CONSTRAINT PK_TestTable5_C2 UNIQUE (Column2)
);

ALTER TABLE TestTable5 ADD CONSTRAINT PK_TestTable5_C3 UNIQUE (Column3);

CREATE TABLE TestTable7 (
	Column1 int NOT NULL,
	Column2 int NOT NULL,
	CONSTRAINT CK_TestTable7_C1 CHECK (Column1 <> 0)
);

ALTER TABLE TestTable7 ADD CONSTRAINT CK_TestTable7_C2 CHECK (Column2 > Column1);

CREATE TABLE TestTable8 (
	Column1 int NULL CONSTRAINT DF_C1 DEFAULT (1),
	Column2 int NULL 
);

ALTER TABLE TestTable8 ADD CONSTRAINT DF_C2 DEFAULT (2) FOR Column2; 


ALTER TABLE TestTable7 DROP CONSTRAINT CK_TestTable7_C1;
ALTER TABLE TestTable7 DROP CONSTRAINT CK_TestTable7_C2;
ALTER TABLE TestTable8 DROP CONSTRAINT DF_C1;
ALTER TABLE TestTable8 DROP CONSTRAINT DF_C2;


