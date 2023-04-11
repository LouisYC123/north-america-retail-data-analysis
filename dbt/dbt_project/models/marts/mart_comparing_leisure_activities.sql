WITH source as (
    SELECT * FROM {{ ref('stg_unpivot_clean') }}
)

SELECT
     date_part('year', sales_month) as sales_year
    , {{ dbt_utils.pivot(
        'type_of_business',
        ['Book stores', 'Sporting goods stores', 'Hobby, toy, and game stores'],
        agg='sum',
        then_value='sales',
    ) }}
FROM 
    source
GROUP BY 
    1