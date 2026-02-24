{% test expression_is_true(model, expression, column_name=None) %}

-- Generic test: return rows that violate a boolean expression.
-- Example usage:
--   - expression_is_true:
--       expression: "quantity >= 0"

select *
from {{ model }}
where not ({{ expression }})

{% endtest %}
