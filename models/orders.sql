MODEL (
  name demo.orders,
  cron '@daily',
  grain order_id,
  audits (UNIQUE_VALUES(columns = (
    order_id
  )), NOT_NULL(columns = (
    order_id
  )))
);

with orders as (

    select * from demo.stg_orders

),

payments as (

    select * from demo.stg_payments

),

order_payments as (

    select
        order_id,
        @EACH(['credit_card', 'coupon', 'bank_transfer', 'gift_card'], x -> sum(case when payment_method = x then amount else 0 end) as @{x}_amount),
        sum(amount) as total_amount

    from payments

    group by order_id

),

final as (

    select
        orders.order_id,
        orders.customer_id,
        orders.order_date,
        orders.status,
        @EACH(['credit_card', 'coupon', 'bank_transfer', 'gift_card'], x -> order_payments.@{x}_amount),
        order_payments.total_amount as amount

    from orders


    left join order_payments
        on orders.order_id = order_payments.order_id

)

select * from final
