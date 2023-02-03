{{
  config(
    materialized='view'
  )
}}
with users as (
    select *
    from {{ ref('stg_users') }}
)
addresses as (
    select *
    from {{ ref('stg_addresses') }} 
)
select
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.phone_number,
    u.created_at,
    u.updated_at,
    a.address,
    a.zipcode,
    a.state,
    a.country
from users as u left outer join
    addresses as a 
on u.address_id = a.address_id
