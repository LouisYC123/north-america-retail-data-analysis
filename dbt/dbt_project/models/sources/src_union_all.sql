
{% for src in var('raw_data_tables') %}
    SELECT * FROM {{ source('retail_source', src.name) }}
    {{ 'union all' if not loop.last }}
{% endfor %}


