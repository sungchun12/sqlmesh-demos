MODEL (
  name demo.seed_org_created,
  kind SEED (
    path '../seeds/org_created.csv'
  ),
  columns (
    org_id INT,
    org_name TEXT,
    domain TEXT,
    employee_range TEXT,
    created_at TIMESTAMP
  ),
  grain (
    org_id
  )
)