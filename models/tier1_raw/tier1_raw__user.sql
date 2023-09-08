{{ config(
    schema='tier1_raw', 
    alias='user',
    materialized='table') }}

WITH session_users as (
   select distinct user_id from {{ ref('stg_sources__sessions') }}
),

conversion_users as (
   select distinct user_id, registration_time from {{ ref('stg_sources__conversions') }}
),

all_users AS(
 SELECT 
  coalesce(c.user_id, s.user_id) as user_id,
  case when c.user_id is not null then true else false end as user_conversion_indicator,
  coalesce(c.registration_time, null) as user_conversion_timestamp
FROM  conversion_users c
full join session_users s on c.user_id = s.user_id )

select 
  sha256(concat(cast(user_id as STRING), cast(user_conversion_indicator as STRING))) as user_gid,
  user_id,
  user_conversion_indicator

from all_users
