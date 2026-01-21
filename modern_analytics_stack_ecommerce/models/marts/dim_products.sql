select
    product_id,
    product_description
from {{ ref('stg_products') }}
