MODEL (
  name demo.seed_model,
  kind SEED (
    path '../../seeds/seed_data.csv'
  ),
  columns (
    id INT,
    item_id INT,
    event_date DATE
  ),
  grain (id, event_date)
)