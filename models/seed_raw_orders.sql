MODEL (
  name demo.seed_raw_orders,
  kind SEED (
    path '../seeds/raw_orders.csv'
  ),
  columns (
    id INT,
    user_id INT,
    order_date DATE,
    status VARCHAR(50)
  ),
  grain (id, user_id)
)