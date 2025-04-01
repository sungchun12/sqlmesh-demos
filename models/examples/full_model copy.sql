MODEL (
  name demo.full_model_example,
  kind FULL,
  cron '@daily',
  grain item_id
);

/* command to generate unit test code in a yaml file */ /* sqlmesh create_test demo.incremental_model --query demo.seed_model "select * from demo.seed_model limit 5" */
SELECT
  item_id,
  COUNT(DISTINCT id) AS num_orders
FROM demo.incremental_model
GROUP BY
  item_id