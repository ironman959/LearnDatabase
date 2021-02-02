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

