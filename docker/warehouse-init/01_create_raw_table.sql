drop table if exists raw.online_retail_raw;

create table raw.online_retail_raw (
  invoice_no   text,
  stock_code   text,
  description  text,
  quantity     integer,
  invoice_date timestamp,
  unit_price   numeric(12, 4),
  customer_id  text,
  country      text
);
