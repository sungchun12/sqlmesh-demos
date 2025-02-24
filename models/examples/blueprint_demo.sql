MODEL (
  name @customer.orders,
  kind VIEW,
  cron '@daily',
  blueprints (
    (customer := customer1, field_a := x, field_b := y, where_clause := "where customer_id = 1"),
    (customer := customer2, field_a := z, field_b := w, where_clause := "where customer_id = 2"),
    (customer := customer3, field_a := a, field_b := b, where_clause := "where customer_id = 3"),
    (customer := customer4, field_a := c, field_b := d, where_clause := "where customer_id = 4"),
    (customer := customer5, field_a := e, field_b := f, where_clause := "where customer_id = 5")
  ),
  enabled true,
  audits (
    unique_combination_of_columns(columns := (
      customer_id, order_id
    )),
    NOT_NULL(columns := (
      customer_id, order_id
    ))
  )
);

SELECT
  customer_id,
  order_id,
  product_name,
  product_category,
  purchase_amount,
  purchase_date,
  country,
  -- for specific customers, I can add columns if they pay for extra analytics
  -- if paid_analytics is true, then add that column, otherwise don't
FROM demo.seed_ecommerce
@where_clause