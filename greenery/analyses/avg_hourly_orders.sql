with orders as (
  select *
  from {{ ref('stg_orders') }}
),

hourly_orders as (select
    date_trunc('hour',created_at) as hour_,
    count(order_id) as num_orders
from orders 
group by hour_)

select 
    avg(num_orders) as avg_orders
from
hourly_orders
