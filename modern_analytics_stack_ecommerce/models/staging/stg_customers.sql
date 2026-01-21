with src as (

    select *
    from {{ ref('stg_online_retail_raw') }}

),

customers as (

    select
        customer_id,
        max(country) as country
    from src
    where customer_id is not null
    group by 1

)

select *
from customers
