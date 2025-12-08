CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
    DECLARE @satart_time DATETIME, @end_time DATETIME, @bronze_s_time DATETIME, @bronze_e_time DATETIME;
    BEGIN TRY
        SET @bronze_s_time = GETDATE();
        PRINT '============================================'
        PRINT 'Loading Bronze Layer'
        PRINT '============================================'

        PRINT '--------------------------------------------'
        PRINT '>> Loading CRM Tables'
        PRINT '--------------------------------------------'

        SET @satart_time = GETDATE();
        TRUNCATE TABLE bronze.crm_cust_info;
        BULK INSERT bronze.crm_cust_info
        FROM 'D:\Marouane\Documents\github\sql-data-warehouse\datasets\source_crm\cust_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE()
        PRINT 'Loading duration: ' + CAST(DATEDIFF(second, @satart_time, @end_time) AS NVARCHAR) + ' seconds.'
        PRINT '--------------------------------------------------------------------------'

        SET @satart_time = GETDATE();
        TRUNCATE TABLE bronze.crm_sales_details;
        BULK INSERT bronze.crm_sales_details
        FROM 'D:\Marouane\Documents\github\sql-data-warehouse\datasets\source_crm\sales_details.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        )
        SET @end_time = GETDATE();
        PRINT 'Loading duration: ' + CAST(DATEDIFF(second, @satart_time, @end_time) AS NVARCHAR) + ' seconds.'
        PRINT '--------------------------------------------------------------------------'

        SET @satart_time = GETDATE();
        TRUNCATE TABLE bronze.crm_prd_info;
        BULK INSERT bronze.crm_prd_info
        FROM 'D:\Marouane\Documents\github\sql-data-warehouse\datasets\source_crm\prd_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE()
        PRINT 'Loading duration: ' + CAST(DATEDIFF(second, @satart_time, @end_time) AS NVARCHAR) + ' seconds.'
        PRINT '--------------------------------------------------------------------------'


        PRINT '--------------------------------------------'
        PRINT '>> Loading ERP Tables'
        PRINT '--------------------------------------------'

        SET @satart_time = GETDATE();
        TRUNCATE TABLE bronze.erp_cust_az12;
        BULK INSERT bronze.erp_cust_az12
        FROM 'D:\Marouane\Documents\github\sql-data-warehouse\datasets\source_erp\cust_az12.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT 'Loading duration: ' + CAST(DATEDIFF(second, @satart_time, @end_time) AS NVARCHAR) + ' seconds.'
        PRINT '--------------------------------------------------------------------------'


        SET @satart_time = GETDATE();
        TRUNCATE TABLE bronze.erp_loc_a101;
        BULK INSERT bronze.erp_loc_a101
        FROM 'D:\Marouane\Documents\github\sql-data-warehouse\datasets\source_erp\loc_a101.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT 'Loading duration: ' + CAST(DATEDIFF(second, @satart_time, @end_time) AS NVARCHAR) + ' seconds.'
        PRINT '--------------------------------------------------------------------------'


        SET @satart_time = GETDATE();
        TRUNCATE TABLE bronze.erp_px_cat_g1v2;
        BULK INSERT bronze.erp_px_cat_g1v2
        FROM 'D:\Marouane\Documents\github\sql-data-warehouse\datasets\source_erp\px_cat_g1v2.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT 'Loading duration: ' + CAST(DATEDIFF(second, @satart_time, @end_time) AS NVARCHAR) + ' seconds.'
        PRINT '--------------------------------------------------------------------------'
        
        
        SET @bronze_e_time = GETDATE();
        PRINT 'Bronze Loading Duration: ' + CAST(DATEDIFF(second, @bronze_s_time, @bronze_e_time) AS NVARCHAR) + ' seconds.'
        PRINT '--------------------------------------------------------------------------'
        
    END TRY
    BEGIN CATCH
        PRINT '==============================='
        PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
        PRINT 'ERROR Message: ' + ERROR_MESSAGE();
        PRINT '==============================='
    END CATCH
END