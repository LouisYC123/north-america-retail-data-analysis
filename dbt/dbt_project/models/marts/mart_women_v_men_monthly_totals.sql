WITH source AS (
    SELECT * FROM {{ ref('int_women_v_men_monthly_totals') }}
)

SELECT
    sales_month
    , {{ dbt_utils.pivot(
        'type_of_business',
        ['mens_clothing_stores', 'womens_clothing_stores'],
        agg='sum',
        then_value='pct_total',
        suffix='_pct_total'
    ) }}
FROM 
    source
GROUP BY 
    1