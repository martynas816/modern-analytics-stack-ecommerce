# E-commerce Revenue Analytics

End-to-end analytics project built on the UCI Online Retail dataset. Raw transaction data is loaded into Postgres, transformed with dbt, and surfaced in Metabase for reporting.

**Stack:** Postgres, dbt, Metabase, Docker

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

## Warehouse outputs

- `raw.online_retail_raw`
- `analytics.fct_order_lines`
- `analytics.dim_customers`
- `analytics.dim_products`
- `analytics.mart_revenue_monthly`
- `analytics.mart_revenue_by_country`
- `analytics.mart_top_products`

## Business logic

- Invoice IDs starting with `C` are treated as cancellations.
- Revenue reporting excludes cancelled invoices.
- Metric definitions are documented in [`docs/metrics.md`](./docs/metrics.md).

## Local setup

1. Start Postgres and Metabase.

```bash
docker compose up -d
```

This starts Postgres on `localhost:5432` and Metabase on `http://localhost:3000`. On first startup, the database init scripts create the schemas, create the raw table, and load `./data/online_retail_raw.csv`.

2. Install Python dependencies.

```bash
pip install -r requirements.txt
```

3. Configure dbt by copying `profiles.yml.example` to your local dbt profiles directory as `profiles.yml`.

- Windows: `C:\Users\<you>\.dbt\profiles.yml`
- macOS/Linux: `~/.dbt/profiles.yml`

4. Build the models and run tests.

```bash
cd modern_analytics_stack_ecommerce
dbt debug
dbt build
```

## Metabase connection

Use the following connection details inside Metabase:

- Host: `warehouse`
- Port: `5432`
- Database: `warehouse`
- Username: `warehouse`
- Password: `warehouse`
