with src as (

    select *
    from {{ ref('stg_online_retail_raw') }}
    where invoice_id is not null

),

orders as (

    select
        invoice_id,

        -- choose a deterministic single value per invoice
        min(ordered_at) as ordered_at,
        max(customer_id) as customer_id,
        max(country) as country,

        -- common Online Retail convention: invoices starting with 'C' are cancellations
        (invoice_id like 'C%') as is_cancelled

    from src
    group by 1, 5

)

select *
from orders
