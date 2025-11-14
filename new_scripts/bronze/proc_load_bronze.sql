CREATE OR REPLACE PROCEDURE bronze.load_bronze()
LANGUAGE plpgsql
AS $$
DECLARE
    start_time TIMESTAMP;
    end_time TIMESTAMP;
    batch_start_time TIMESTAMP;
    batch_end_time TIMESTAMP;
    load_duration INTERVAL;
    total_duration INTERVAL;
    base_path TEXT := 'C:/Users/admin/Desktop/projects/johnajayi/data_engineering/sql-data-warehouse-project/datasets';
BEGIN
    BEGIN
        batch_start_time := clock_timestamp();
        RAISE NOTICE '================================================';
        RAISE NOTICE 'Loading Bronze Layer';
        RAISE NOTICE '================================================';

        RAISE NOTICE '------------------------------------------------';
        RAISE NOTICE 'Loading CRM Tables';
        RAISE NOTICE '------------------------------------------------';

        -- crm_cust_info
        start_time := clock_timestamp();
        RAISE NOTICE '>> Truncating Table: bronze.crm_cust_info';
        TRUNCATE TABLE bronze.crm_cust_info;
        RAISE NOTICE '>> Inserting Data Into: bronze.crm_cust_info';
        EXECUTE format('COPY bronze.crm_cust_info FROM %L WITH (FORMAT csv, HEADER)', 
                      base_path || '/source_crm/cust_info.csv');
        end_time := clock_timestamp();
        load_duration := end_time - start_time;
        RAISE NOTICE '>> Load Duration: % seconds', EXTRACT(EPOCH FROM load_duration);
        RAISE NOTICE '>> -------------';

        -- crm_prd_info
        start_time := clock_timestamp();
        RAISE NOTICE '>> Truncating Table: bronze.crm_prd_info';
        TRUNCATE TABLE bronze.crm_prd_info;
        RAISE NOTICE '>> Inserting Data Into: bronze.crm_prd_info';
        EXECUTE format('COPY bronze.crm_prd_info FROM %L WITH (FORMAT csv, HEADER)', 
                      base_path || '/source_crm/prd_info.csv');
        end_time := clock_timestamp();
        load_duration := end_time - start_time;
        RAISE NOTICE '>> Load Duration: % seconds', EXTRACT(EPOCH FROM load_duration);
        RAISE NOTICE '>> -------------';

        -- crm_sales_details
        start_time := clock_timestamp();
        RAISE NOTICE '>> Truncating Table: bronze.crm_sales_details';
        TRUNCATE TABLE bronze.crm_sales_details;
        RAISE NOTICE '>> Inserting Data Into: bronze.crm_sales_details';
        EXECUTE format('COPY bronze.crm_sales_details FROM %L WITH (FORMAT csv, HEADER)', 
                      base_path || '/source_crm/sales_details.csv');
        end_time := clock_timestamp();
        load_duration := end_time - start_time;
        RAISE NOTICE '>> Load Duration: % seconds', EXTRACT(EPOCH FROM load_duration);
        RAISE NOTICE '>> -------------';

        RAISE NOTICE '------------------------------------------------';
        RAISE NOTICE 'Loading ERP Tables';
        RAISE NOTICE '------------------------------------------------';
        
        -- erp_loc_a101
        start_time := clock_timestamp();
        RAISE NOTICE '>> Truncating Table: bronze.erp_loc_a101';
        TRUNCATE TABLE bronze.erp_loc_a101;
        RAISE NOTICE '>> Inserting Data Into: bronze.erp_loc_a101';
        EXECUTE format('COPY bronze.erp_loc_a101 FROM %L WITH (FORMAT csv, HEADER)', 
                      base_path || '/source_erp/loc_a101.csv');
        end_time := clock_timestamp();
        load_duration := end_time - start_time;
        RAISE NOTICE '>> Load Duration: % seconds', EXTRACT(EPOCH FROM load_duration);
        RAISE NOTICE '>> -------------';

        -- erp_cust_az12
        start_time := clock_timestamp();
        RAISE NOTICE '>> Truncating Table: bronze.erp_cust_az12';
        TRUNCATE TABLE bronze.erp_cust_az12;
        RAISE NOTICE '>> Inserting Data Into: bronze.erp_cust_az12';
        EXECUTE format('COPY bronze.erp_cust_az12 FROM %L WITH (FORMAT csv, HEADER)', 
                      base_path || '/source_erp/cust_az12.csv');
        end_time := clock_timestamp();
        load_duration := end_time - start_time;
        RAISE NOTICE '>> Load Duration: % seconds', EXTRACT(EPOCH FROM load_duration);
        RAISE NOTICE '>> -------------';

        -- erp_px_cat_g1v2
        start_time := clock_timestamp();
        RAISE NOTICE '>> Truncating Table: bronze.erp_px_cat_g1v2';
        TRUNCATE TABLE bronze.erp_px_cat_g1v2;
        RAISE NOTICE '>> Inserting Data Into: bronze.erp_px_cat_g1v2';
        EXECUTE format('COPY bronze.erp_px_cat_g1v2 FROM %L WITH (FORMAT csv, HEADER)', 
                      base_path || '/source_erp/px_cat_g1v2.csv');
        end_time := clock_timestamp();
        load_duration := end_time - start_time;
        RAISE NOTICE '>> Load Duration: % seconds', EXTRACT(EPOCH FROM load_duration);
        RAISE NOTICE '>> -------------';

        batch_end_time := clock_timestamp();
        total_duration := batch_end_time - batch_start_time;
        RAISE NOTICE '==========================================';
        RAISE NOTICE 'Loading Bronze Layer is Completed';
        RAISE NOTICE '   - Total Load Duration: % seconds', EXTRACT(EPOCH FROM total_duration);
        RAISE NOTICE '==========================================';
        
    EXCEPTION
        WHEN OTHERS THEN
            RAISE NOTICE '==========================================';
            RAISE NOTICE 'ERROR OCCURRED DURING LOADING BRONZE LAYER';
            RAISE NOTICE 'Error Message: %', SQLERRM;
            RAISE NOTICE 'Error Code: %', SQLSTATE;
            RAISE NOTICE '==========================================';
    END;
END;
$$;