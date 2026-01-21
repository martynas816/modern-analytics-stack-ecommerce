select
    oi.invoice_id,
    o.ordered_at,
    o.customer_id,
    o.country,
    o.is_cancelled,

    oi.product_id,
    p.product_description,

    oi.quantity,
    oi.unit_price,
    oi.line_revenue

from {{ ref('stg_order_items') }} oi
left join {{ ref('stg_orders') }} o
  on oi.invoice_id = o.invoice_id
left join {{ ref('stg_products') }} p
  on oi.product_id = p.product_id
