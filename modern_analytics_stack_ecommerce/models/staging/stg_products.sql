with src as (

    select *
    from {{ ref('stg_online_retail_raw') }}

),

products as (

    select
        product_id,
        max(product_description) as product_description
    from src
    where product_id is not null
    group by 1

)

select *
from products
