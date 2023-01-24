with orders as (
  select *
  from {{ ref('stg_orders') }}
)
select 
    avg(datediff(day,created_at,delivered_at)) as delivery_time
from orders
where 
    created_at is not null and 
    delivered_at is not null and 
    delivered_at > created_at