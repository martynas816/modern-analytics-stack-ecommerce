# Stakeholder request: “What happened yesterday?”

## Goal
Answer quickly with **trusted numbers** and a short explanation.

## Query (yesterday KPIs)
```sql
-- Postgres
with base as (
  select *
  from analytics.fct_order_lines
  where is_cancelled = false
    and ordered_at::date = current_date - 1
)
select
  count(distinct invoice_id) as orders,
  count(distinct customer_id) as customers,
  sum(quantity) as units,
  sum(line_revenue) as revenue
from base;
```

## Validation (don’t skip)
- Sanity check cancellations excluded (`is_cancelled = false`).
- Compare with last 7 days average to spot anomalies.

## Response template
- **Yesterday revenue:** X (orders: Y, customers: Z)
- **Driver:** (e.g., higher orders in top country, top products)
- **Confidence:** (validated cancellations excluded; no duplicate-line spike)
