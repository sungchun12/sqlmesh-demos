MODEL (
  name demo.seed_subscription_created,
  kind SEED (
    path '../seeds/subscription_created.csv'
  ),
  columns (
    org_id INT,
    event_timestamp TIMESTAMP,
    activity TEXT,
    plan TEXT,
    price INT,
    deployment TEXT
  ),
  grain (
    org_id
  )
)