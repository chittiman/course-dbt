{{
  config(
    materialized='view'
  )
}}
with orders as (
  select *
  from {{ ref('stg_orders') }}
),
promos as (
  select *
  from {{ ref('stg_promos') }}
)
select 
    o.*,
    p.discount,
    p.status
from 
    orders as o left outer join
    promos as p
on o.promo_id = p.promo_id
    

