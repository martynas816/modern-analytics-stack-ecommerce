{% macro portable_date_trunc(granularity, ts_expr) %}
  {#
    Returns a DATE at the requested granularity.
    - Postgres: date_trunc('month', ordered_at)::date
    - BigQuery: DATE_TRUNC(DATE(ordered_at), MONTH)
  #}

  {% if target.type in ['bigquery'] %}
    DATE_TRUNC(DATE({{ ts_expr }}), {{ granularity | upper }})
  {% else %}
    date_trunc('{{ granularity }}', {{ ts_expr }})::date
  {% endif %}
{% endmacro %}
