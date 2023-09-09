
  
    

    create or replace table `analytics-engineering-398318`.`ae_tier1_raw`.`channel`
      
    
    

    OPTIONS()
    as (
      

WITH channel_seed as (
   select * from `analytics-engineering-398318`.`ae_sources`.`channel_seed`
)
select 
 sha256(cs.channel_name) as channel_gid,
 cs.channel_name,
 cast(cs.channel_prio as INTEGER) as channel_priority_number,
 cast(cs.channel_lifespan as INTEGER) as channel_lifespan_duration
from channel_seed cs
    );
  