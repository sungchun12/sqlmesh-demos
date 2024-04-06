MODEL (
  name demo.stg_customers,
  cron '@daily',
  grain org_id,
  audits (UNIQUE_VALUES(columns = (
    customer_id
  )), NOT_NULL(columns = (
    customer_id
  )))
);

SELECT
  id AS customer_id,
  first_name,
  last_name,
  1 as new_column -- non-breaking change
FROM demo.seed_raw_customers