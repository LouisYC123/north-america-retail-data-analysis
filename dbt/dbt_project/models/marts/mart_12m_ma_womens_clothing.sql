WITH source AS (
    SELECT * FROM {{ ref('stg_unpivot_clean')}}
)

SELECT 
    sales_month
    , sales
    , ROUND(avg(sales) OVER(ORDER BY sales_month ROWS BETWEEN 11 PRECEDING AND CURRENT ROW), 2) AS moving_avg
    , count(sales) OVER(ORDER BY sales_month ROWS BETWEEN 11 PRECEDING AND CURRENT ROW) AS records_count
FROM 
    source
WHERE
    type_of_business = 'Women''s clothing stores'