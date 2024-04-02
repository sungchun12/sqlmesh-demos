MODEL (
  name demo.seed_raw_customers,
  kind SEED (
    path '../../seeds/raw_customers.csv'
  ),
  columns (
    id INT,
    first_name INT,
    last_name DATE
  ),
  grain (id)
)