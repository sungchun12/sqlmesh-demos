MODEL (
  name demo.stg_payments,
  cron '@daily',
  grain payment_id,
  audits (UNIQUE_VALUES(columns = (
    payment_id
  )), NOT_NULL(columns = (
    payment_id
  )))
);



select
    id as payment_id,
    order_id,
    payment_method,
    amount / 100 as amount --`amount` is currently stored in cents, so we convert it to dollars

from demo.seed_raw_payments