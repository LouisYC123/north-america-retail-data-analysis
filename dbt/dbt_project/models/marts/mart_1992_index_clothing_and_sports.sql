WITH source as (
    SELECT * FROM {{ ref('int_1992_index_clothing_and_sports') }}
)

SELECT
    sales_year
    , {{ dbt_utils.pivot(
        'type_of_business',
        ['mens_clothing_stores', 'womens_clothing_stores', 'sporting_goods'],
        agg='sum',
        then_value='pct_from_index',
    ) }}
FROM 
    source
GROUP BY 
    1