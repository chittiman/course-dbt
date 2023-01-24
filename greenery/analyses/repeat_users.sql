with orders as (
  select *
  from {{ ref('stg_orders') }}
),
num_orders_per_user as(
select 
    user_id,
    count(order_id) as num_orders
from orders
group by user_id
)
select 
    count(user_id)
from num_orders_per_user
where num_orders > 3
    
