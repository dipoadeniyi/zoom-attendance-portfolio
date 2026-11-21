# Zoom attendance ELT portfolio

This project demonstrates the dbt transformation layer of an attendance pipeline. It uses synthetic data and an in-memory DuckDB database.

The original workflow extracts Zoom attendance through the REST API, lands CSVs in Amazon S3, loads Snowflake and transforms the data with dbt. Airflow orchestrates the batch. Separate implementations use Databricks and Microsoft Fabric. This demo focuses on SQL modelling, deduplication and data quality checks.

## Run the demo

1. Create and activate a Python virtual environment.
2. Run `python -m pip install -r requirements.txt`.
3. Run `dbt build --profiles-dir .`.

The mart should return three rows for one session. Two learners attended and one was absent. An unmatched display name is excluded, and a repeated join record contributes duration only once.

The mart grain is one row per learner per session. It assumes each rostered learner is expected at every session in the sample.
