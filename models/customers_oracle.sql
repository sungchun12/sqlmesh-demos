MODEL (
  name "demo"."customers_oracle",
  cron '@daily',
  -- grain customer_id,
  dialect oracle,
);

WITH customers AS (
  SELECT
    *
  FROM "demo"."stg_customers"
), orders AS (
  SELECT
    *
  FROM "demo"."stg_orders"
), payments AS (
  SELECT
    *
  FROM "demo"."stg_payments"
), customer_orders AS (
  SELECT
    customer_id,
    MIN(order_date) AS first_order,
    MAX(order_date) AS most_recent_order,
    COUNT(order_id) AS number_of_orders,
    order_id || order_date AS order_id_order_date,
    NVL(order_id, 0) AS order_id_nonulls, -- COALESCE(`ORDER_ID`, 0) AS `ORDER_ID_NONULLS`,  
    order_id::string AS order_id_string, -- CAST(order_id AS STRING) AS order_id_string, 
    TO_NUMBER(order_id) AS order_id_number, -- Oracle TO_NUMBER example # CAST(`orders`.`order_id` AS FLOAT64) AS `order_id_number`, 
    TO_CHAR(order_date) AS order_date_converted, -- Oracle TO_CHAR example # CAST(`orders`.`order_date` AS STRING) AS `order_date_converted`,
  FROM orders
  GROUP BY
    customer_id,
    order_id,
    order_date_converted,
    order_id_order_date,
    order_id_string,
    order_id_number,
    order_id_nonulls,
), customer_payments AS (
  SELECT
    orders.customer_id,
    CASE WHEN amount > STDDEV(amount) THEN 'High Value' ELSE 'Low Value' END AS payment_tier,
    SUM(amount) AS total_amount
  FROM payments
  LEFT JOIN orders
    ON payments.order_id = orders.order_id
  GROUP BY
    orders.customer_id,
    amount
), final AS (
  SELECT
    customers.customer_id,
    customers.first_name,
    customers.last_name,
    customer_orders.first_order,
    customer_orders.most_recent_order,
    customer_orders.number_of_orders,
    customer_orders.order_id_order_date,
    customer_orders.order_date_converted,
    customer_orders.order_id_number,
    customer_orders.order_id_string,
    customer_orders.order_id_nonulls,
    customer_payments.payment_tier,
    customer_payments.total_amount AS customer_lifetime_value
  FROM customers
  LEFT JOIN customer_orders
    ON customers.customer_id = customer_orders.customer_id
  LEFT JOIN customer_payments
    ON customers.customer_id = customer_payments.customer_id
)
SELECT /*+ PARALLEL(4) */
  *
FROM final
FETCH FIRST 10 ROWS ONLY