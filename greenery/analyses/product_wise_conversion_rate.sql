with events as (
  select *
  from {{ ref('stg_events') }}),

products as (
  select *
  from {{ ref('stg_products') }}),
  
page_view_sessions as (
select
    product_id,
    count (distinct session_id) as num_page_views
from events
where event_type = 'page_view'
group by product_id),

checkout_sessions as (
select
    product_id,
    count (distinct session_id) as num_purchase_sessions
from events
where event_type = 'add_to_cart'
group by product_id),

conversion_rates as (select 
    u.product_id,
    round(c.num_purchase_sessions/u.num_page_views,2) as conversion_rate
from page_view_sessions as u inner join 
    checkout_sessions as c
on u.product_id = c.product_id)

select
    p.product_id,
    p.name,
    p.price,
    coalesce(c.conversion_rate,0) as conversion_rate
from 
    products as p left outer join
    conversion_rates as c
on p.product_id = c.product_id





