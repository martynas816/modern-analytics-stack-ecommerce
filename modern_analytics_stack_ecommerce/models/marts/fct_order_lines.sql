select
    invoice_id,
    ordered_at::date as order_date,
    ordered_at,
    customer_id,
    country,
    product_id,
    quantity,
    unit_price,
    line_revenue,
    is_cancelled
from {{ ref('int_order_lines_enriched') }}



-- select
--     oi.invoice_id,
--     o.ordered_at::date as order_date,
--     oi.ordered_at,
--     oi.customer_id,
--     oi.country,
--     oi.product_id,
--     oi.quantity,
--     oi.unit_price,
--     oi.line_revenue,
--     o.is_cancelled
-- from {{ ref('stg_order_items') }} oi
-- left join {{ ref('stg_orders') }} o
--   on oi.invoice_id = o.invoice_id
