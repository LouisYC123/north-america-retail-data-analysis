
{{ dbt_utils.unpivot(
    relation=ref('src_union_raw'),
    cast_to='varchar',
    exclude=['year', 'naics_code', 'type_of_business', 'load_timestamp'],
    field_name='month',
    value_name='sales'
) }}
