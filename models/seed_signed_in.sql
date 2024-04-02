MODEL (
  name demo.seed_signed_in,
  kind SEED (
    path '../seeds/signed_in.csv'
  ),
  columns (
    org_id INT,
    event_timestamp TIMESTAMP,
    activity TEXT
  ),
  grain (org_id, event_timestamp, activity)
)