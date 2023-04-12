WITH source as (
    SELECT * FROM {{ ref('int_1992_index_of_clothing_stores') }}
)

SELECT
    sales_year
    , {{ dbt_utils.pivot(
        'type_of_business',
        ['mens_clothing_stores', 'womens_clothing_stores'],
        agg='sum',
        then_value='pct_from_index',
    ) }}
FROM 
    source
GROUP BY 
    1