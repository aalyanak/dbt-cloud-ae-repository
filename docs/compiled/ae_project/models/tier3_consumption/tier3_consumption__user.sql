

WITH users as (
   select * from `analytics-engineering-398318`.`ae_tier2_curated`.`user`
)

select 
  user_id,
  user_conversion_indicator

from users