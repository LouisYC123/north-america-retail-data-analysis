{{ config(severity = 'warn') }}

with stage as (
    SELECT * FROM {{ ref('stg_unpivot_clean') }}
)

SELECT 
    {{ dbt_utils.star(ref('stg_unpivot_clean')) }}
    , COUNT(*)
FROM 
    stage
GROUP BY
    {{ dbt_utils.star(ref('stg_unpivot_clean')) }}
HAVING 
    COUNT(*) > 1