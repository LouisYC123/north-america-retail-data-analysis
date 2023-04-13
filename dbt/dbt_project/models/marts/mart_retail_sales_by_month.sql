WITH source as (
    SELECT * FROM {{ ref('stg_unpivot_clean') }}
)

SELECT 
    sales_month
    , sales
FROM 
    source 
WHERE 
    type_of_business = 'Retail and food services sales, total'



