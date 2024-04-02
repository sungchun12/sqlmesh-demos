MODEL (
  name demo.stg_orders,
  cron '@daily',
  grain order_id,
  audits (UNIQUE_VALUES(columns = (
    order_id
  )), NOT_NULL(columns = (
    order_id
  )))
);


select
    id as order_id,
    user_id as customer_id,
    order_date,
    status

from demo.seed_raw_orders
