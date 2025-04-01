MODEL (
  name demo.incremental_by_unique_key_example,
  kind INCREMENTAL_BY_UNIQUE_KEY (
    unique_key id
  ),
  start '2020-01-01',
  cron '@daily'
);

SELECT
  id,
  item_id,
  event_date
FROM demo.seed_model
WHERE
  event_date BETWEEN @start_date AND @end_date