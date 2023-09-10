
  
    

    create or replace table `analytics-engineering-398318`.`ae_tier2_curated`.`user`
      
    
    

    OPTIONS()
    as (
      

WITH users as (
   select * from `analytics-engineering-398318`.`ae_tier1_raw`.`user`
)

select 
  user_id,
  user_conversion_indicator

from users
    );
  