MODEL (
  name demo.seed_user_created,
  kind SEED (
    path '../seeds/user_created.csv'
  ),
  columns (
    user_id INT,
    org_id INT,
    first_name VARCHAR,
    last_name VARCHAR,
    email VARCHAR,
    is_first_user BOOLEAN,
    created_at timestamp,
  ),
  grain (user_id)
)