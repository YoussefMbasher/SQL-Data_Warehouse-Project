EXEC bronze.load_bronze;

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
  BEGIN TRY
		print'=============================================';
		print 'Load Bronze Layer';
		print'=============================================';

		print'=============================================';
		print'Loading CRM Tables';
		print'=============================================';
		DECLARE @Start_time DATETIME,@end_time DATETIME

		SET @Start_time=GETDATE();
		PRINT'Truncate Table :bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info

		PRINT'Insert Data into :bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		from 'C:\Users\yousef\Downloads\SQL_DataWare house Material\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		with(
			firstrow=2,
			FIELDTERMINATOR=',',
			TABLOCK
		);
		SET @end_time=GETDATE();
		PRINT'>>Load Duration : '+CAST(DATEDIFF(SECOND,@Start_time,@end_time) AS NVARCHAR)+'Second';
		--select * from  bronze.crm_cust_info;

		SET @Start_time=GETDATE();
		PRINT'Truncate Table :bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info

		PRINT'Insert Data into :bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		from 'C:\Users\yousef\Downloads\SQL_DataWare house Material\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		with(
			firstrow=2,
			FIELDTERMINATOR=',',
			TABLOCK
		);
		SET @end_time=GETDATE();
		PRINT'>>Load Duration : '+CAST(DATEDIFF(SECOND,@Start_time,@end_time) AS NVARCHAR)+'Second';
		--select * from  bronze.crm_prd_info;

		SET @Start_time=GETDATE();
		PRINT'Truncate Table :bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details
		PRINT'Insert Data into :bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		from 'C:\Users\yousef\Downloads\SQL_DataWare house Material\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		with(
			firstrow=2,
			FIELDTERMINATOR=',',
			TABLOCK
		);
		SET @end_time=GETDATE();
		PRINT'>>Load Duration : '+CAST(DATEDIFF(SECOND,@Start_time,@end_time) AS NVARCHAR)+'Second';
		--select * from  bronze.crm_sales_details;

		print'=============================================';
		print'Loading ERP Tables';
		print'=============================================';

		SET @Start_time=GETDATE();
		PRINT'Truncate Table :bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12
		PRINT'Insert Data into  :bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		from 'C:\Users\yousef\Downloads\SQL_DataWare house Material\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
		with(
			firstrow=2,
			FIELDTERMINATOR=',',
			TABLOCK
		);
		SET @end_time=GETDATE();
		PRINT'>>Load Duration : '+CAST(DATEDIFF(SECOND,@Start_time,@end_time) AS NVARCHAR)+'Second';
		--select * from  bronze.erp_cust_az12;

		SET @Start_time=GETDATE();
		PRINT'Truncate Table :bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101

		PRINT'Insert Data into :bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		from 'C:\Users\yousef\Downloads\SQL_DataWare house Material\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
		with(
			firstrow=2,
			FIELDTERMINATOR=',',
			TABLOCK
		);
		SET @end_time=GETDATE();
		PRINT'>>Load Duration : '+CAST(DATEDIFF(SECOND,@Start_time,@end_time) AS NVARCHAR)+'Second';

		--select * from  bronze.erp_loc_a101;
		SET @Start_time=GETDATE();
		PRINT'Truncate Table :bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2

		PRINT'Insert Data into : bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		from 'C:\Users\yousef\Downloads\SQL_DataWare house Material\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
		with(
			firstrow=2,
			FIELDTERMINATOR=',',
			TABLOCK
		);
		SET @end_time=GETDATE();
		PRINT'>>Load Duration : '+CAST(DATEDIFF(SECOND,@Start_time,@end_time) AS NVARCHAR)+'Second';

	END TRY

	BEGIN CATCH
	PRINT'=========================================='
	PRINT'Error During Loading Bronze Layer'
	PRINT'Error Message'+ERROR_MESSAGE();
	PRINT'Error Message'+CAST(ERROR_NUMBER() AS NVARCHAR);
	PRINT'Error Message'+CAST(ERROR_STATE() AS NVARCHAR);
	PRINT'=========================================='
	END CATCH

	--select * from  bronze.erp_px_cat_g1v2;

END
