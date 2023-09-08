
{{ config(
    schema='tier1_raw', 
    alias='user_conversion_without_live_session',
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
  select * from {{ ref('tier1_raw__user_conversion_organic_live_session') }}
),

wo_live_session as (
  select 
    uc.user_gid, 
    us.user_session_gid, 
    CASE 
            WHEN c.channel_name is not null and c.channel_name = '{{ var("direct") }}' THEN  '{{ var("direct") }}' 
            ELSE  '{{ var("other") }}' 
    END as conversion_channel_name,
    CASE
        WHEN us.user_gid is not null then row_number() over (partition by us.user_gid order by c.channel_priority_number) 
        WHEN us.user_gid is null then 1 
  END as rownr
  from user_conversion uc 
  left join user_session us on us.user_gid = uc.user_gid and uc.user_conversion_timestamp >= us.user_session_start_timestamp
  left join channel c on us.user_session_channel_gid = c.channel_gid
  left join paid_live_session pls on us.user_gid=pls.user_gid
  left join organic_live_session ols on us.user_gid=ols.user_gid
  where pls.user_gid is null and ols.user_gid is null
),

wo_live_session_final as (
    select 
        wls.user_gid,
        wls.user_session_gid, --nullable
        c.channel_gid as user_conversion_channel_gid
    from wo_live_session wls
    inner join channel c on wls.conversion_channel_name=c.channel_name
    where wls.rownr=1
)

select * from wo_live_session_final