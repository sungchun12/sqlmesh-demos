MODEL (
  name demo.seed_feature_used,
  kind SEED (
    path '../seeds/feature_used.csv'
  ),
  columns (
    org_id INT,
    event_timestamp timestamp,
    activity VARCHAR
  ),
  grain (org_id, event_timestamp, activity)
)