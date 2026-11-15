use Salesdb;
go
create or alter procedure Sales.stored_P @getSalesPersonID NVARCHAR(10)
as
Begin try
	if exists (select * from Salesdb.sales.orders where sales is null and salespersonid =  @getSalesPersonID )
	Begin 
		Update Salesdb.Sales.Orders
		Set Sales = 0
		Where sales is null and salespersonid =  @getSalesPersonID;
		PRINT('Updating NULL Scores to 0')
	END
	ELSE
	BEGIN 
		PRINT('No NULL values found')
	END
	;
	Begin 
	Declare @avg_Sales int, @SalesPerson Float
		SELECT * FROM Salesdb.sales.Orders Where SalesPersonID = @getSalesPersonID 
		;
		SELECT @SalesPerson = salespersonid, @avg_Sales = avg(sales) From Salesdb.sales.Orders
		Where SalesPersonID = @getSalesPersonID
		Group by salespersonid
		;
		Print('For SalesPersonID ' + cast(@SalesPerson as varchar) +' the avg sales is ' + Cast(@avg_Sales as varchar))
	END
End Try
BEGIN CATCH
        /* --------------------------------------------------------------------------
           Error Handling
        -------------------------------------------------------------------------- */
        PRINT('An error occurred.');
        PRINT('Error Message: ' + ERROR_MESSAGE());
        PRINT('Error Number: ' + CAST(ERROR_NUMBER() AS NVARCHAR));
        PRINT('Error Severity: ' + CAST(ERROR_SEVERITY() AS NVARCHAR));
        PRINT('Error State: ' + CAST(ERROR_STATE() AS NVARCHAR));
        PRINT('Error Line: ' + CAST(ERROR_LINE() AS NVARCHAR));
        PRINT('Error Procedure: ' + ISNULL(ERROR_PROCEDURE(), 'N/A'));
 END CATCH;
;
go
EXEC Sales.stored_P @getSalesPersonID = 'sam'


