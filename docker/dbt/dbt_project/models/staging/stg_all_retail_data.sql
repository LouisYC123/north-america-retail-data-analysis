with stg_all_retail as (

{{ dbt_utils.union_relations(

    relations=[source('retail', 'raw_1992_data'), source('retail', 'raw_1993_data'), source('retail', 'raw_1994_data')]

) 
}}

)

select * from stg_all_retail