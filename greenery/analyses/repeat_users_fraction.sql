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
    sum(case 
        when num_orders > 1 then 1 
        else null
       end)/count(*) as repeat_user_rate
from num_orders_per_user