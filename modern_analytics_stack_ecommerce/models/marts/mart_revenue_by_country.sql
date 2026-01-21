select
    country,
    sum(line_revenue) as revenue,
    count(distinct invoice_id) as orders,
    count(distinct customer_id) as customers
from {{ ref('fct_order_lines') }}
where is_cancelled = false
group by 1
order by revenue desc
