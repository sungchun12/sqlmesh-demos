MODEL (
  name demo.seed_raw_payments,
  kind SEED (
    path '../seeds/raw_payments.csv'
  ),
  columns (
    id INT,
    order_id INT,
    payment_method TEXT(50),
    amount INT
  ),
  grain (id, user_id)
)