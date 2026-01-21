with src as (

    select *
    from {{ ref('stg_online_retail_raw') }}

),

items as (

    select
        invoice_id,
        ordered_at,
        customer_id,
        country,

        product_id,
        product_description,

        quantity,
        unit_price,
        (quantity * unit_price) as line_revenue

    from src
    where invoice_id is not null
      and product_id is not null

)

select *
from items
