WITH source AS (
    SELECT * FROM {{ ref('stg_unpivot_clean') }}
)

SELECT 
	sales_month
	, type_of_business 
	, sales 
	, SUM(sales) OVER(PARTITION BY sales_month) AS total_sales
	, sales * 100 / sum(sales) OVER(PARTITION BY sales_month) as pct_total
FROM 
	source
WHERE 
	type_of_business IN ('Men''s clothing stores', 'Women''s clothing stores')