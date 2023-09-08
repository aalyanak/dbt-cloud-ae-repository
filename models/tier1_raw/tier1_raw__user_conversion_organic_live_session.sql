
{{ config(
    schema='tier1_raw', 
    alias='user_conversion_organic_live_session',
    materialized='table') }}

WITH user_conversion as (
  select * from {{ ref('tier1_raw__user_conversion') }}
),

user_session as (
  select * from {{ ref('tier1_raw__user_session') }}
),

channel as (
  select * from {{ ref('tier1_raw__channel') }}
),

paid_live_session as (
  select * from {{ ref('tier1_raw__user_conversion_paid_live_session') }}
),

organic_live_session as (
  select 
    us.user_gid, 
    us.user_session_gid, 
    us.user_session_start_timestamp, 
    uc.user_conversion_timestamp, 
    row_number() over(partition by uc.user_gid order by us.user_session_start_timestamp) as rownr
  from user_session us
  inner join user_conversion uc on us.user_gid=uc.user_gid
  inner join channel c on us.user_session_channel_gid=c.channel_gid
  left join paid_live_session pls on uc.user_gid = pls.user_gid
  where uc.user_conversion_timestamp between us.user_session_start_timestamp and us.user_session_end_timestamp
  and c.channel_name = '{{ var("organic_click") }}'
  and pls.user_gid is null
)

select 
 ols.user_gid,
 ols.user_session_gid
 from organic_live_session ols
where ols.rownr=1