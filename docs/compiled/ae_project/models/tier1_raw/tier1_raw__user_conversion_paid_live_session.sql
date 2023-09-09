

WITH user_conversion as (
  select * from `analytics-engineering-398318`.`ae_tier1_raw`.`user_conversion`
),

user_session as (
  select * from `analytics-engineering-398318`.`ae_tier1_raw`.`user_session`
),

channel as (
  select * from `analytics-engineering-398318`.`ae_tier1_raw`.`channel`
),

paid_live_session as (
  select 
    us.user_gid, 
    us.user_session_gid, 
    us.user_session_start_timestamp, 
    uc.user_conversion_timestamp, 
    row_number() over(partition by uc.user_gid order by us.user_session_start_timestamp) as rownr
  from user_session us
  inner join user_conversion uc on us.user_gid=uc.user_gid
  inner join channel c on us.user_session_channel_gid=c.channel_gid
  where uc.user_conversion_timestamp between us.user_session_start_timestamp and us.user_session_end_timestamp
  and c.channel_name in ('paid_click', 'paid_impression')
)

select 
 pls.user_gid,
 pls.user_session_gid
 from paid_live_session pls
where rownr=1