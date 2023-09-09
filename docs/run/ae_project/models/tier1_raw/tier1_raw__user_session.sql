
  
    

    create or replace table `analytics-engineering-398318`.`ae_tier1_raw`.`user_session`
      
    
    

    OPTIONS()
    as (
      

WITH  __dbt__cte__stg_sources__sessions as (
with
    source as (select * from `analytics-engineering-398318`.`ae_sources`.`sessions`),

    session_final as (
        select distinct user_id, time_started, is_paid, medium from source
    )

select *
from session_final
), session as (
    select distinct * from __dbt__cte__stg_sources__sessions
),

user as(
    select distinct * from `analytics-engineering-398318`.`ae_tier1_raw`.`user`
),

channel as (
   select distinct * from `analytics-engineering-398318`.`ae_tier1_raw`.`channel`
),

session_curated AS (
  SELECT DISTINCT
    u.user_gid,
    s.user_id,
    s.time_started as user_session_start_timestamp,
    s.is_paid,
    s.medium,
    CASE
      WHEN s.is_paid = true and s.medium='PAID SEARCH' then 'paid_click'
      WHEN s.is_paid = true and s.medium in ('PAID SOCIAL', 'DISPLAY') then 'paid_impression'
      WHEN s.is_paid = false and s.medium='ORGANIC SEARCH' then  'organic_click'
      WHEN s.is_paid = false and s.medium='DIRECT' then  'direct'
      ELSE  'other'
    END as session_channel_name
   from session s
   inner join user u on s.user_id = u.user_id
),

session_channel_curated as (
    select * from session_curated cs
    inner join channel c on cs.session_channel_name = c.channel_name
),

session_final AS (
    SELECT
    sha256(concat(TO_BASE64(user_gid),cast(user_session_start_timestamp as string))) as user_session_gid,
    user_gid,
    user_session_start_timestamp,
    CASE 
    WHEN session_channel_name = 'paid_click' THEN TIMESTAMP_ADD(user_session_start_timestamp, INTERVAL session_channel_curated.channel_lifespan_duration HOUR)
    WHEN session_channel_name = 'paid_impression' THEN TIMESTAMP_ADD(user_session_start_timestamp, INTERVAL session_channel_curated.channel_lifespan_duration HOUR)
    WHEN session_channel_name = 'organic_click' THEN TIMESTAMP_ADD(user_session_start_timestamp, INTERVAL session_channel_curated.channel_lifespan_duration HOUR)
    ELSE null END as user_session_end_timestamp,
    channel_gid as user_session_channel_gid

    from session_channel_curated)

select * from session_final
    );
  