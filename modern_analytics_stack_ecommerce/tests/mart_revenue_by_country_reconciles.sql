-- Data test: mart_revenue_by_country must reconcile to fct_order_lines (excluding cancellations).

with fct as (
    select
        country,
        sum(line_revenue)::numeric(18, 4) as revenue
    from {{ ref('fct_order_lines') }}
    where is_cancelled = false
    group by 1
),

mart as (
    select
        country,
        revenue::numeric(18, 4) as revenue
    from {{ ref('mart_revenue_by_country') }}
)

select
    coalesce(fct.country, mart.country) as country,
    fct.revenue as fct_revenue,
    mart.revenue as mart_revenue
from fct
full outer join mart using (country)
where coalesce(fct.revenue, 0) <> coalesce(mart.revenue, 0)
