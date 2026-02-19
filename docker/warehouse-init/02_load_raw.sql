-- The CSV lives at /data inside the container (mounted from ./data)
copy raw.online_retail_raw (
  invoice_no,
  stock_code,
  description,
  quantity,
  invoice_date,
  unit_price,
  customer_id,
  country
)
from '/data/online_retail_raw.csv'
with (format csv, header true, delimiter ',', encoding 'LATIN1');
