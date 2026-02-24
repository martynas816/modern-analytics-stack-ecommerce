# Metrics & definitions

This project uses the **Online Retail** transaction convention where invoices that start with **`C`** are treated as **cancellations**.

## Core tables and grains

- **`raw.online_retail_raw`** (source)
  - Grain: one invoice line from the input CSV.

- **`analytics.fct_order_lines`** (fact)
  - Grain: **one invoice line** (`invoice_id` + `product_id` + `ordered_at` from the raw feed).
  - `is_cancelled`: `true` when `invoice_id like 'C%'`.

- **`analytics.dim_customers`**
  - Grain: one `customer_id`.

- **`analytics.dim_products`**
  - Grain: one `product_id`.

## Revenue logic

### Line revenue
- **`line_revenue`** = `quantity * unit_price`.

### Revenue used in marts
All revenue marts **exclude cancelled invoices**:

- Filter: `is_cancelled = false`
- **Revenue** = `sum(line_revenue)`

> Note: In the Online Retail dataset, cancellation lines may carry negative quantities/revenue.
> By excluding `is_cancelled = true`, the marts aim to represent realized (non-cancelled) sales.

## Standard aggregates

These metrics appear in marts/dashboards:

- **Orders** = `count(distinct invoice_id)` over `is_cancelled = false`
- **Customers** = `count(distinct customer_id)` over `is_cancelled = false`
- **Units** = `sum(quantity)` over `is_cancelled = false`

## Marts

- **`analytics.mart_revenue_monthly`**
  - Grain: one row per calendar month (`month`)
  - Revenue/orders/customers/units computed from `fct_order_lines` where `is_cancelled = false`.

- **`analytics.mart_revenue_by_country`**
  - Grain: one row per country
  - Revenue/orders/customers computed from `fct_order_lines` where `is_cancelled = false`.

- **`analytics.mart_top_products`**
  - Grain: one row per product
  - Revenue/units/orders computed from `fct_order_lines` where `is_cancelled = false`.
