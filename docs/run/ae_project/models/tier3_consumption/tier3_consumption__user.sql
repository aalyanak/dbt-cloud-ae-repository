
  
    

    create or replace table `analytics-engineering-398318`.`ae_tier3_consumption`.`user`
      
    
    

    OPTIONS()
    as (
      

WITH users as (
   select * from `analytics-engineering-398318`.`ae_tier2_curated`.`user`
)

select 
  user_id,
  user_conversion_indicator

from users
    );
  