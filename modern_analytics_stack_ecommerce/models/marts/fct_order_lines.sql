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
