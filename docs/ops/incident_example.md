# Example incident (an incident that might happen and how it would be dealt with): revenue spike after reload

## What happened
A stakeholder reported that the **monthly revenue dashboard suddenly spiked** compared with the previous day.

## Impact
- Revenue KPI showed a sudden increase without any corresponding change in orders/customers.
- This undermined trust in the dashboard for daily reporting.

## Triage checklist (10 minutes)
1. **Freshness:** confirm the raw table was updated when expected.
2. **Row counts:** compare `raw.online_retail_raw` and `analytics.fct_order_lines` row counts to the previous day.
3. **Duplicates:** check for duplicate invoice lines (same `invoice_id` + `product_id` + `quantity` + `unit_price` + `ordered_at`).
4. **Cancellations:** confirm cancellations (`invoice_id like 'C%'`) are excluded from revenue marts.

## Root cause (example)
The raw CSV load was re-run and appended instead of replaced, introducing **duplicate invoice lines**.

## Fix
- Rebuild the raw load to be **idempotent** (replace or truncate+load).
- Add a **dbt test** / query-based check to detect duplicates at the invoice-line grain.

## Prevention
- Keep raw loads **repeatable** (no double-inserts on rerun).
- Add a lightweight monitoring query for:
  - daily row count change
  - duplicate invoice-line rate
  - revenue delta beyond threshold

## Useful SQL snippets

### Duplicate invoice-line check (Postgres)
```sql
select
  invoice_id,
  product_id,
  ordered_at::date as ordered_date,
  quantity,
  unit_price,
  count(*) as dup_cnt
from analytics.fct_order_lines
group by 1,2,3,4,5
having count(*) > 1
order by dup_cnt desc;
```

### Revenue delta sanity check
```sql
select
  month,
  revenue,
  lag(revenue) over (order by month) as prev_revenue,
  revenue - lag(revenue) over (order by month) as delta
from analytics.mart_revenue_monthly
order by month;
```
