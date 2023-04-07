{% macro get_sources(source_prefix) %}
    {% set sources = [] %}
    {% if execute %}
    {% for node_name, node in graph.nodes.items() %}
        {% if node.resource_type == 'source' %}
            {% do sources.append(node.name) %}
        {% endif %}
    {% endfor %}
    {% do return(sources) %}
    {% endif %}
{% endmacro %}



