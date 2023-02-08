with events as (
  select *
  from {{ ref('stg_events') }}
),

page_view_sessions as (
select
    count (distinct session_id) as num_page_views
from events
where event_type = 'page_view'),

purchase_sessions as (
select
    count (distinct session_id) as num_purchase_sessions
from events
where event_type = 'add_to_cart')

select 
    round(c.num_purchase_sessions/u.num_page_views,2) as overall_conversion_rate
from page_view_sessions as u cross join 
    purchase_sessions as c
