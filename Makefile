up:
	docker compose up -d

down:
	docker compose down

reset:
	docker compose down -v

dbt-build:
	cd modern_analytics_stack_ecommerce && dbt build

dbt-docs:
	cd modern_analytics_stack_ecommerce && dbt docs generate
