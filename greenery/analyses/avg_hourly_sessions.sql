with orders as (
  select *
  from dev_db.dbt_chitreddysairamgmailcom.stg_events
),
hourly_sessions as (
select 
    date_trunc('hour',created_at) as hour_,
    count(distinct session_id) as num_sessions
from orders
group by 1)
select 
    avg(num_sessions) as avg_sessions
from hourly_sessions