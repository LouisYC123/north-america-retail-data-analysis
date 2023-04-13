{{ config(materialized='view') }}

{% for src in var('raw_data_tables') %}
    {%- set col_names = adapter.get_columns_in_relation(source('retail_source', src.name)) -%}
    SELECT
        REPLACE(REPLACE('{{src.name}}', 'raw_',''), '_data','') AS year
        {%- for column in col_names -%}
            {% if column.name != 'TOTAL' %}
                {% if column.name == 'Unnamed: 0' %}
                    , "{{ column.name }}"::TEXT AS "naics_code"
                {% elif column.name == 'Unnamed: 1' %}
                    , "{{ column.name }}"::TEXT AS "type_of_business"
                {% elif column.name == 'load_timestamp' %}
                    , "{{ column.name }}"::TEXT AS "load_timestamp"
                {% else %}
                    , "{{ column.name }}"::TEXT AS "{{column.name[:3].lower()}}"
                {% endif %}
            {% endif %}
        {%- endfor %}
    FROM 
        {{ source('retail_source', src.name) }}
    WHERE 
        "Unnamed: 1" NOT IN ('ADJUSTED(2)', 'NOT ADJUSTED')
        AND "Unnamed: 1" IS NOT NULL

    {{ 'union all' if not loop.last }}
{% endfor %}

 