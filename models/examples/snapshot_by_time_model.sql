MODEL (
  name demo.snapshot_by_time_model,
  kind SCD_TYPE_2_BY_TIME (
    unique_key id,
    updated_at_name event_date
  ),
  enabled false
);

SELECT
  id::INT64,
  item_id::INT64,
  event_date::DATE
FROM demo.seed_model