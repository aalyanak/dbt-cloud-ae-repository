{{ config(
    schema='tier2_curated', 
    alias='user_conversion',
    materialized='table') }}

WITH users AS (
    select * from {{ ref('tier1_raw__user') }}
),

user_conversion AS (
    select * from {{ ref('tier1_raw__user_conversion') }}
),

user_session AS (
    select * from {{ ref('tier1_raw__user_session') }}
),

channel AS (
    select * from {{ ref('tier1_raw__channel') }}
),

live_session AS (
    select * from {{ ref('tier1_raw__user_conversion_paid_live_session') }}
    union all
    select * from {{ ref('tier1_raw__user_conversion_organic_live_session') }}
),

wo_live_session AS (
    select * from {{ ref('tier1_raw__user_conversion_without_live_session') }}
),

live_session_channel AS (
    select ls.*, c.channel_gid as user_conversion_channel_gid
    from live_session ls
    inner join user_session us on ls.user_session_gid = us.user_session_gid
    inner join channel c on us.user_session_channel_gid=c.channel_gid
),

user_conversion_all as (
    select * from live_session_channel
    union all
    select * from wo_live_session
),

user_conversion_final as (
    select 
        u.user_id,
        c.channel_name as user_conversion_channel_name,
        uc.user_conversion_timestamp
    from user_conversion_all uca
    inner join users u on uca.user_gid = u.user_gid
    inner join user_conversion uc on uca.user_gid=uc.user_gid
    inner join channel c on uca.user_conversion_channel_gid = c.channel_gid
)

select * from user_conversion_final