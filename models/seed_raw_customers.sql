MODEL (
  name demo.seed_raw_customers,
  kind SEED (
    path '../seeds/raw_customers.csv'
  ),
  columns (
    id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
  ),
  grain (id)
)