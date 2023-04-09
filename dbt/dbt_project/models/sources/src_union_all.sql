

{% for src in var('raw_data_tables') %}
    SELECT 
    {% for col in adapter.get_columns_in_relation(source('retail_source', src.name)) -%}
        {{ clean_col_names(col.name) }} 
    {% endfor %}
       
    FROM 
        {{ source('retail_source', src.name) }}
    {{ 'union all' if not loop.last }}
{% endfor %}