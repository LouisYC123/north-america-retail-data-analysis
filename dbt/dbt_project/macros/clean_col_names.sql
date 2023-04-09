{% macro clean_col_names(column_name) %}
CASE
    WHEN '{{ column_name }}' = 'Unamed: 0' THEN '{{ column_name }}'
    WHEN '{{ column_name }}' = 'Unamed: 1' THEN '{{ column_name }}'
    ELSE CAST(replace('{{ column_name }}', '.', '_') AS TEXT)
END
{% endmacro %}
