WITH stage AS (
    SELECT * FROM {{ref('stg_unpivot')}}
)

SELECT DISTINCT
    TO_DATE(CONCAT(year,'-',month,'-','01'), 'YYYY Mon DD') AS "sales_month"
    , naics_code
    , type_of_business
    , CASE 
        WHEN sales = '(NA)' THEN NULL 
        WHEN sales = '(S)' THEN NULL 
        ELSE sales::INTEGER
    END AS sales
    , load_timestamp::TIMESTAMP
FROM 
    stage