WITH source AS (
    SELECT * FROM {{ ref('stg_unpivot_clean')}}
)

SELECT
	date_part('month', sales_month) as month_num
	, round(avg(sales), 2) as avg_sales
FROM 
	source
WHERE 
	type_of_business = 'Book stores'
GROUP BY 
	1
