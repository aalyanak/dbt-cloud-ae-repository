{{ config(
    schema='tier1_raw', 
    alias='channel',
    materialized='table') }}

WITH channel_seed as (
   select * from {{ ref('channel_seed') }}
)
select 
 sha256(cs.channel_name) as channel_gid,
 cs.channel_name,
 cast(cs.channel_prio as INTEGER) as channel_priority_number,
 cast(cs.channel_lifespan as INTEGER) as channel_lifespan_duration
from channel_seed cs
