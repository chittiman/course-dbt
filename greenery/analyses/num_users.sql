with users as (
  select *
  from {{ ref('stg_users') }}
)

select 
    count(distinct user_id) as num_users
from users
