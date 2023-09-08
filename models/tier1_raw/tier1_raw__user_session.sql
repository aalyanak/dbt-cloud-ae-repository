{{ config(
    schema='tier1_raw', 
    alias='user_session',
    materialized='table') }}

WITH session as (
    select distinct * from {{ ref('stg_sources__sessions') }}
),

user as(
    select distinct * from {{ ref('tier1_raw__user') }}
),

channel as (
   select distinct * from {{ ref('tier1_raw__channel') }}
),

session_curated AS (
  SELECT DISTINCT
    u.user_gid,
    s.user_id,
    s.time_started as user_session_start_timestamp,
    s.is_paid,
    s.medium,
    CASE
      WHEN s.is_paid = true and s.medium='PAID SEARCH' then '{{ var("paid_click") }}'
      WHEN s.is_paid = true and s.medium in ('PAID SOCIAL', 'DISPLAY') then '{{ var("paid_impression") }}'
      WHEN s.is_paid = false and s.medium='ORGANIC SEARCH' then  '{{ var("organic_click") }}'
      WHEN s.is_paid = false and s.medium='DIRECT' then  '{{ var("direct") }}'
      ELSE  '{{ var("other") }}'
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
    WHEN session_channel_name = '{{ var("paid_click") }}' THEN TIMESTAMP_ADD(user_session_start_timestamp, INTERVAL {{ "session_channel_curated.channel_lifespan_duration" }} HOUR)
    WHEN session_channel_name = '{{ var("paid_impression") }}' THEN TIMESTAMP_ADD(user_session_start_timestamp, INTERVAL {{ "session_channel_curated.channel_lifespan_duration" }} HOUR)
    WHEN session_channel_name = '{{ var("organic_click") }}' THEN TIMESTAMP_ADD(user_session_start_timestamp, INTERVAL {{ "session_channel_curated.channel_lifespan_duration" }} HOUR)
    ELSE null END as user_session_end_timestamp,
    channel_gid as user_session_channel_gid

    from session_channel_curated)

select * from session_final
