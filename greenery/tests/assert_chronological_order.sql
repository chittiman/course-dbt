select *
from {{ ref('stg_orders' )}}
where created_at > delivered_at