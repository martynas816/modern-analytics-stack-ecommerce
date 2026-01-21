select
    customer_id,
    country
from {{ ref('stg_customers') }}
