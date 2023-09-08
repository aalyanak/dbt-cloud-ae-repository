{{ config(
    schema='tier3_consumption', 
    alias='user_conversion',
    materialized='table') }}

WITH user_conversion AS (
    select * from {{ ref('tier2_curated__user_conversion') }}
)
select 
    user_id,
    user_conversion_channel_name,
    user_conversion_timestamp
from user_conversion