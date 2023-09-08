{{ config(
    schema='tier1_raw', 
    alias='user_conversion',
    materialized='table') }}

WITH users as (
    select * from {{ ref('tier1_raw__user') }}
    where user_conversion_indicator=true),

conversion as (
    select * from {{ ref('stg_sources__conversions') }}
),

user_conversion as (
    select 
    u.user_gid,
    c.registration_time as user_conversion_timestamp
    from users u
    inner join conversion c on u.user_id=c.user_id
)

select * from user_conversion