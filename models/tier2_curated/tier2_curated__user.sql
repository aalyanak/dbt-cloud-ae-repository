{{ config(
    schema='tier2_curated', 
    alias='user',
    materialized='table') }}

WITH users as (
   select * from {{ ref('tier1_raw__user') }}
)

select 
  user_id,
  user_conversion_indicator

from users