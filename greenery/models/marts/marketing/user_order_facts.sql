{{
  config(
    materialized='view'
  )
}}
with users as (
    select *
    from {{ ref('stg_users') }}
),
orders as (
    select *
    from {{ ref('stg_orders') }}
),
addresses as (
    select *
    from {{ ref('stg_addresses') }}
),
user_order_info as ( 
select
    u.user_id,
    u.address_id,
    coalesce(count(o.order_id),0) as num_orders,
    coalesce(sum(o.order_cost),0) as total_order_cost,
    min(o.created_at) as first_ordered_date,
    max(o.created_at) as recent_ordered_date
from users as u left outer join
    orders as o
on u.user_id = o.user_id
group by u.user_id,u.address_id)
select 
    u.*,
    a.address,
    a.zipcode,
    a.state,
    a.country
from user_order_info as u left outer join
    addresses as a 
on u.address_id = a.address_id