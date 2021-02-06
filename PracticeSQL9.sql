USE TestDB
GO

BEGIN TRY
BEGIN TRANSACTION 
				
				UPDATE Product SET CategoryId = 2
				WHERE ProductId = 1


				UPDATE Product SET CategoryId = NULL
				WHERE ProductId = 2
END TRY
		BEGIN CATCH
				
						ROLLBACK TRANSACTION 

						SELECT ERROR_NUMBER() AS [Number error],
							   ERROR_MESSAGE() AS [Description error]

						RETURN;
		END CATCH
COMMIT TRANSACTION 

