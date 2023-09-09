
  
    

    create or replace table `analytics-engineering-398318`.`ae_tier3_consumption`.`user_conversion`
      
    
    

    OPTIONS()
    as (
      

WITH user_conversion AS (
    select * from `analytics-engineering-398318`.`ae_tier2_curated`.`user_conversion`
)
select 
    user_id,
    user_conversion_channel_name,
    user_conversion_timestamp
from user_conversion
    );
  