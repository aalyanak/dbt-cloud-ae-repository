{{ config(
    schema='tier3_consumption', 
    alias='user',
    materialized='table') }}

WITH users as (
   select * from {{ ref('tier2_curated__user') }}
)

select 
  user_id,
  user_conversion_indicator

from users