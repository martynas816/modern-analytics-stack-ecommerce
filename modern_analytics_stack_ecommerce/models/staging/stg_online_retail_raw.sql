    with source as (

    select *
    from {{ source('raw', 'online_retail_raw') }}

),

renamed as (

    select
        invoice_no as invoice_id,
        stock_code as product_id,
        nullif(trim(description), '') as product_description,
        quantity,
        invoice_date as ordered_at,
        unit_price,
        nullif(trim(customer_id), '') as customer_id,
        nullif(trim(country), '') as country
    from source

)

select *
from renamed
