CREATE LOGIN [Misha] WITH PASSWORD='1234',
				     DEFAULT_DATABASE=[TestDB]
GO

EXEC sp_addsrvrolemember @loginame = 'Misha', @rolename = 'sysadmin'
GO


CREATE USER [Admin] FOR LOGIN [Misha]
GO

EXEC sp_addrolemember 'db_owner', 'Admin'
GO

USE TestDB


ALTER DATABASE TestDB SET READ_ONLY

ALTER DATABASE TestDB SET READ_WRITE

BACKUP DATABASE TestDB
		 TO DISK = 'D:\backup_DB\TestDB.bak'
		 WITH NAME = 'Database TestDB',
		 STATS = 10
GO

USE master

DROP DATABASE TestDB;

RESTORE DATABASE TestDB
		FROM DISK = 'D:\backup_DB\TestDB.bak'
		WITH FILE = 1,
		STATS = 10
GO
