{{ config(severity = 'warn') }}

with stage as (
    SELECT * FROM {{ ref('stg_unpivot_clean') }}
)

SELECT 
    *
FROM 
    stage
WHERE 
    sales < 0