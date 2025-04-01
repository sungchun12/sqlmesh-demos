MODEL (
  name customer1.custom,
  kind VIEW,
  cron '@daily'
);

SELECT
  customer_persona,
  'custom analytics' AS custom_analytics
FROM customer1.orders