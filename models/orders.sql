MODEL (
  name demo.orders,
  cron '@daily',
  grain order_id,
  audits (UNIQUE_VALUES(columns = (
    order_id
  )), NOT_NULL(columns = (
    order_id
  )))
);

WITH orders AS (
  SELECT
    *
  FROM demo.stg_orders
), payments AS (
  SELECT
    *
  FROM demo.stg_payments
), order_payments AS (
  SELECT
    order_id,
    @EACH(
      ['credit_card', 'coupon', 'bank_transfer', 'gift_card'],
      x -> SUM(CASE WHEN payment_method = x THEN amount ELSE 0 END) AS @{x}_amount
    ),
    SUM(amount) AS total_amount
  FROM payments
  GROUP BY
    order_id
), final AS (
  SELECT
    orders.order_id,
    orders.customer_id,
    orders.order_date,
    orders.status,
    @EACH(
      ['credit_card', 'coupon', 'bank_transfer', 'gift_card'],
      x -> order_payments.@{x}_amount
    ),
    order_payments.total_amount AS amount
  FROM orders
  LEFT JOIN order_payments
    ON orders.order_id = order_payments.order_id
)
SELECT
  *
FROM final