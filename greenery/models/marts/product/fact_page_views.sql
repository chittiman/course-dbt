{{
  config(
    materialized='view'
  )
}}
with events as (
  select *
  from {{ ref('stg_events') }}
),
products as (
  select *
  from {{ ref('stg_products') }}
),
product_events as (
select 
   product_id,
   to_date(created_at) as event_date,
   sum(case 
        when event_type='page_view' then 1
      else 0
      end) as daily_page_views,
  sum(case 
        when event_type='add_to_cart' then 1
      else 0
      end) as daily_cart_additions,
  sum(case 
        when event_type='checkout' then 1
      else 0
      end) as daily_checkouts,
  sum(case 
        when event_type='package_shipped' then 1
      else 0
      end) as daily_package_shipments
from events
group by product_id,event_date)
select
   p.*,
   e.*
from products as p left outer join 
    product_events as e
on p.product_id = e.product_id