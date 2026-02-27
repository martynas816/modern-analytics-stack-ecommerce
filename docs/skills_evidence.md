# Data analytics skills shown (evidence map)

This repo is built to mirror a real analytics workflow: **raw data → warehouse → dbt modeling + tests → dashboards + stakeholder support**.

Use this as a quick “proof index” to scan the repo.

## SQL + data modeling
- **Staging models (cleaning + typing):** `modern_analytics_stack_ecommerce/models/staging/`
- **Intermediate modeling:** `modern_analytics_stack_ecommerce/models/intermediate/int_order_lines_enriched.sql`
- **Fact + dims (star-ish layer):**
  - `modern_analytics_stack_ecommerce/models/marts/fct_order_lines.sql`
  - `modern_analytics_stack_ecommerce/models/marts/dim_customers.sql`
  - `modern_analytics_stack_ecommerce/models/marts/dim_products.sql`

## Metrics + KPI definitions
- **Metric definitions and grain:** `docs/metrics.md`
- **Revenue marts used by dashboards:**
  - `modern_analytics_stack_ecommerce/models/marts/mart_revenue_monthly.sql`
  - `modern_analytics_stack_ecommerce/models/marts/mart_revenue_by_country.sql`
  - `modern_analytics_stack_ecommerce/models/marts/mart_top_products.sql`

## Data quality & testing
- **dbt tests (not_null/unique/relationships + basic expectations):**
  - `modern_analytics_stack_ecommerce/models/staging/schema.yml`
  - `modern_analytics_stack_ecommerce/models/marts/schema.yml`

## Dashboards / BI
- **Metabase dashboard screenshots:** `assets/` (see README)
- **Dashboards driven by marts in `analytics.*` schema**

## Stakeholder support (day-to-day analytics)
- **Commercial support playbook:** `docs/support_playbook/`
  - “what happened yesterday?”
  - “why did KPI change?”
  - “pull numbers for campaign/segment X”

## Reliability / operations mindset
- **Example incident write-up (debugging + prevention):** `docs/ops/incident_example.md`

## Cloud portability (BigQuery / Looker Studio)
- **Port guide:** `docs/bigquery_looker_port.md`
- **Portable SQL macro example:** `modern_analytics_stack_ecommerce/macros/portable_date_trunc.sql`
