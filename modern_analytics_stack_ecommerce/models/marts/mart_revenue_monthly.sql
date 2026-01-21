with base as (

    select *
    from {{ ref('fct_order_lines') }}
    where is_cancelled = false

),

agg as (

    select
        date_trunc('month', ordered_at)::date as month,
        sum(line_revenue) as revenue,
        count(distinct invoice_id) as orders,
        count(distinct customer_id) as customers,
        sum(quantity) as units
    from base
    group by 1

)

select *
from agg
order by month
