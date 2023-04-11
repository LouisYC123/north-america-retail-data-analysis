WITH source as (
    SELECT * FROM {{ ref('stg_unpivot_clean') }}
)

SELECT 
    date_part('year', sales_month) as sales_year
    , sum(sales) as sales
FROM 
    source 
WHERE 
    type_of_business = 'Retail and food services sales, total'
GROUP BY 
    1