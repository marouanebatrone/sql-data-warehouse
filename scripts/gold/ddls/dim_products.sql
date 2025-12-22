CREATE VIEW gold.dim_products AS
SELECT
ROW_NUMBER() OVER(ORDER BY cpi.prd_start_dt, cpi.prd_key) AS product_key,
cpi.prd_id AS product_id,
cpi.prd_key AS product_number,
cpi.prd_nm AS product_name,
cpi.prd_cost AS product_cost,
cpi.prd_line AS product_line,
cpi.cat_id AS category_id,
epc.CAT AS category,
epc.SUBCAT AS subcategory,
epc.MAINTENANCE AS maintenance,
cpi.prd_start_dt AS start_date
FROM silver.crm_prd_info cpi
LEFT JOIN silver.erp_px_cat_g1v2 epc
ON epc.ID = cpi.cat_id
WHERE prd_end_dt IS NULL;
