MODEL (
  name demo.seed_subscription_created,
  kind SEED (
    path '../seeds/subscription_created.csv'
  ),
  columns (
    org_id INT,
    event_timestamp TIMESTAMP,
    activity VARCHAR,
    plan VARCHAR,
    price INT,
    deployment VARCHAR
  ),
  grain (org_id)
)