select
    p.product_id,
    p.product_description,
    sum(f.quantity) as units,
    sum(f.line_revenue) as revenue,
    count(distinct f.invoice_id) as orders
from {{ ref('fct_order_lines') }} f
left join {{ ref('dim_products') }} p
  on f.product_id = p.product_id
where f.is_cancelled = false
group by 1, 2
order by revenue desc
limit 50
