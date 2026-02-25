/* 
=====================================================

Store Procedure:Load Bronze Layer (Source-> Bronze)

=====================================================
Script Purpose:
This stored procedure loads data into 'bronze' schema from external CSV files.
it proforms the following actions:
-Truncates the bronze tables before loading data
_Uses the 'BULK INSERT' command to load data from csv files to bronze tables.

Parameters:
	None.
		This stored procedures does not accept any parameters or return any valvues.
	Usage Example:
	EXEC bronze.load_bronze;
=====================================================
*/

EXEC bronze.load_bronze;

USE Datawarehouse;
GO
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME;
	BEGIN TRY
		PRINT'=========================================';
		PRINT 'Loading data into Bronze schema tables...';
		PRINT'=========================================';

		PRINT '--------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '--------------------------------';

		SET @start_time = GETDATE();
		PRINT'>> Truncating Table: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;

		PRINT'>> Inserting Data into: bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\Administrator\Documents\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK

		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: '+CAST( DATEDIFF(second, @start_time, @end_time) AS VARCHAR) + ' seconds';
		PRINT '--------------------------------';


		SET @start_time = GETDATE();
		PRINT'>> Truncating Table: bronze.crm_prd_info';
		TRUNCATE TABLE  bronze.crm_prd_info;

		PRINT'>> Inserting Data into: bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\Administrator\Documents\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '\n',
			FIELDQUOTE = '"',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: '+CAST( DATEDIFF(second, @start_time, @end_time) AS VARCHAR) + ' seconds';
		PRINT '--------------';


		SET @start_time = GETDATE();
		PRINT'>> Truncating Table: bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;

		PRINT'>> Inserting Data into: bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\Administrator\Documents\source_crm\sales_details.csv'
		"C:\Users\Administrator\Documents\source_crm\sales_details.csv"
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: '+CAST( DATEDIFF(second, @start_time, @end_time) AS VARCHAR) + ' seconds';
		PRINT '----------------------';



		PRINT '--------------------------------';
		PRINT 'Loading ERP Tables';
		PRINT '--------------------------------'; 

		SET @start_time = GETDATE();
		PRINT'>> Truncating Table: bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101;

		PRINT'>> Inserting Data into: bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\Administrator\Documents\source_erp\loc_a101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: '+CAST( DATEDIFF(second, @start_time, @end_time) AS VARCHAR) + ' seconds';
		PRINT '----------------------';


		SET @start_time = GETDATE();
		PRINT'>> Truncating Table: bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12;

		PRINT'>> Inserting Data into: bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\Administrator\Documents\source_erp\cust_az12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: '+CAST( DATEDIFF(second, @start_time, @end_time) AS VARCHAR) + ' seconds';
		PRINT '----------------------';


		SET @start_time = GETDATE();
		PRINT'>> Truncating Table: bronze.erp_px_cat_giv2';
		TRUNCATE TABLE bronze.erp_px_cat_giv2;

		PRINT'>> Inserting Data into: bronze.erp_px_cat_giv2';
		BULK INSERT bronze.erp_px_cat_giv2
		FROM 'C:\Users\Administrator\Documents\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: '+CAST( DATEDIFF(second, @start_time, @end_time) AS VARCHAR) + ' seconds';
		PRINT '----------------------';

	END TRY
	BEGIN CATCH
		PRINT '============================================='
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
		PRINT 'Error Message: ' + ERROR_MESSAGE();
		PRINT 'ERROR Message: ' + CAST (ERROR_NUMBER() AS VARCHAR);
		PRINT 'ERROR Message: ' + CAST (ERROR_STATE() AS VARCHAR);
		PRINT '============================================='
	END CATCH
END

