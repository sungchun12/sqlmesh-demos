MODEL (
  name demo.seed_org_created,
  kind SEED (
    path '../seeds/org_created.csv'
  ),
  columns (
    org_id INT,
    org_name VARCHAR,
    domain VARCHAR,
    employee_range VARCHAR,
    created_at timestamp
  ),
  grain (org_id)
)