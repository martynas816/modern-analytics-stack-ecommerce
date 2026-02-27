# Stakeholder request: “Pull numbers for segment X” (country/product/customer)

## Example: numbers for a single country (last 30 days)
```sql
select
  country,
  count(distinct invoice_id) as orders,
  count(distinct customer_id) as customers,
  sum(quantity) as units,
  sum(line_revenue) as revenue
from analytics.fct_order_lines
where is_cancelled = false
  and ordered_at::date >= current_date - 30
  and country = 'United Kingdom'
group by 1;
```

## Make it reusable
- Swap `country = ...` for product/customer filters.
- Keep the same KPI set so answers are consistent.
