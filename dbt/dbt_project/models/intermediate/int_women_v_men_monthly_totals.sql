WITH source AS (
    SELECT * FROM {{ ref('stg_unpivot_clean') }}
)

SELECT 
	sales_month
	, CASE
		WHEN type_of_business = 'Men''s clothing stores' THEN 'mens_clothing_stores' 
		ELSE 'womens_clothing_stores'
      END AS type_of_business
	, sales 
	, SUM(sales) OVER(PARTITION BY sales_month) AS total_sales
	, sales * 100 / sum(sales) OVER(PARTITION BY sales_month) as pct_total
FROM 
	source
WHERE 
	type_of_business IN ('Men''s clothing stores', 'Women''s clothing stores')
	AND sales_month < '2021-01-01'