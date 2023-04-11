WITH source AS (
    SELECT * FROM {{ ref('stg_unpivot_clean') }}
)

SELECT
     date_part('year', sales_month) as sales_year
    , {{ dbt_utils.pivot(
        'type_of_business',
        ['Men\'s clothing stores', 'Women\'s clothing stores'],
        agg='sum',
        then_value='sales',
    ) }}
FROM 
    source
GROUP BY 
    1