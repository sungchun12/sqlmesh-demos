MODEL (
  name demo.seed_user_created,
  kind SEED (
    path '../seeds/user_created.csv'
  ),
  columns (
    user_id INT,
    org_id INT,
    first_name TEXT,
    last_name TEXT,
    email TEXT,
    is_first_user BOOLEAN,
    created_at TIMESTAMP
  ),
  grain (
    user_id
  )
)