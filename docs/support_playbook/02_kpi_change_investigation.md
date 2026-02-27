# Stakeholder request: “Why did revenue drop/spike?”

## Investigation pattern
1) Confirm it’s real (freshness, duplicates, cancellations)
2) Decompose: **country → product → customer segment**
3) Summarize the top drivers

## Step 1: validate data quality
```sql
-- Check yesterday vs day before
with d as (
  select ordered_at::date as d, sum(line_revenue) as revenue
  from analytics.fct_order_lines
  where is_cancelled = false
    and ordered_at::date in (current_date - 1, current_date - 2)
  group by 1
)
select * from d order by d;
```

## Step 2: find drivers by country
```sql
with base as (
  select
    ordered_at::date as d,
    country,
    sum(line_revenue) as revenue
  from analytics.fct_order_lines
  where is_cancelled = false
    and ordered_at::date in (current_date - 1, current_date - 2)
  group by 1,2
)
select
  country,
  sum(case when d = current_date - 1 then revenue else 0 end) as rev_yday,
  sum(case when d = current_date - 2 then revenue else 0 end) as rev_prev,
  (sum(case when d = current_date - 1 then revenue else 0 end)
   - sum(case when d = current_date - 2 then revenue else 0 end)) as delta
from base
group by 1
order by abs(delta) desc
limit 10;
```

## Response template
- KPI moved by **ΔX**.
- Top drivers: **Country A (Δ..), Country B (Δ..)**.
- Next check: top products within the top driver country.
