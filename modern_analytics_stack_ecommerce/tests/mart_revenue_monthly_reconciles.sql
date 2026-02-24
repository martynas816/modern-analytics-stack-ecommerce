-- Data test: mart_revenue_monthly must reconcile to fct_order_lines (excluding cancellations).
-- Fails if there is any mismatch between the mart and the underlying fact aggregation.

with fct as (
    select
        date_trunc('month', ordered_at)::date as month,
        sum(line_revenue)::numeric(18, 4) as revenue
    from {{ ref('fct_order_lines') }}
    where is_cancelled = false
    group by 1
),

mart as (
    select
        month,
        revenue::numeric(18, 4) as revenue
    from {{ ref('mart_revenue_monthly') }}
)

select
    coalesce(fct.month, mart.month) as month,
    fct.revenue as fct_revenue,
    mart.revenue as mart_revenue
from fct
full outer join mart using (month)
where coalesce(fct.revenue, 0) <> coalesce(mart.revenue, 0)
