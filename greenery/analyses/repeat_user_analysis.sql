with orders as (
  select *
  from {{ ref('stg_orders') }}
),
users as (
  select *
  from {{ ref('stg_users') }}
),
num_orders_per_user as(
select 
    user_id,
    count(order_id) as num_orders
from orders
group by user_id
)
select 
    u.*,
    n.num_orders
from users  as u left outer join
    num_orders_per_user as n
on u.user_id = n.user_id