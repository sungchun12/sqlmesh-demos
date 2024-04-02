MODEL (
  name demo.seed_raw_payments,
  kind SEED (
    path '../../seeds/raw_payments.csv'
  ),
  columns (
    id INT,
    order_id INT,
    payment_method VARCHAR(50),
    account INT
  ),
  grain (id, user_id)
)