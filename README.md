# Modern Analytics Stack - E-commerce

End-to-end analytics project built on the UCI Online Retail dataset: CSV ingestion into Postgres, dbt transformations, and Metabase reporting.

## Dashboard

**Overview**
<img src="./assets/dashboard_overview.png" width="950" />

<details>
  <summary>Additional views</summary>

  **Revenue by month**
  <img src="./assets/revenue_monthly.png" width="950" />

  **Revenue by country**
  <img src="./assets/revenue_by_country.png" width="950" />

  **Top products**
  <img src="./assets/top_products.png" width="450" />

</details>

## dbt lineage

<img src="./assets/dbt_lineage.png" width="950" />

## Outputs

- `raw.online_retail_raw`
- `analytics.fct_order_lines`
- `analytics.dim_customers`
- `analytics.dim_products`
- `analytics.mart_revenue_monthly`
- `analytics.mart_revenue_by_country`
- `analytics.mart_top_products`

Invoices beginning with `C` are treated as cancellations. Revenue marts exclude cancelled invoices.

Metric definitions: [`docs/metrics.md`](./docs/metrics.md)

## Run locally

```bash
docker compose up -d
pip install -r requirements.txt
```

Copy `profiles.yml.example` to your local dbt profiles directory as `profiles.yml`, then run:

```bash
cd modern_analytics_stack_ecommerce
dbt build
```

## Metabase connection

Use the following Postgres settings inside Metabase:

- Host: `warehouse`
- Port: `5432`
- Database: `warehouse`
- Username: `warehouse`
- Password: `warehouse`
