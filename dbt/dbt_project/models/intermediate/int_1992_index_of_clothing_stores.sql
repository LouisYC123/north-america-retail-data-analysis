WITH source AS (
    SELECT * FROM {{ ref('stg_unpivot_clean') }}
)

SELECT 
    sales_year
    , type_of_business 
    , sales
    , first_value(sales) OVER(PARTITION BY type_of_business ORDER BY sales_year) AS first
    , sales - first_value(sales) OVER(PARTITION BY type_of_business ORDER BY sales_year) AS diff

FROM 
    (
        SELECT 
            date_part('year', sales_month) AS sales_year 
            , CASE
                WHEN type_of_business = 'Men''s clothing stores' THEN 'mens_clothing_stores' 
                ELSE 'womens_clothing_stores'
            END AS type_of_business
            , sum(sales) AS sales 
        FROM 
            source 
        WHERE 
            type_of_business IN ('Men''s clothing stores', 'Women''s clothing stores')
            AND sales_month <= '2019-12-31'
        GROUP BY  
            1, 2
    ) a