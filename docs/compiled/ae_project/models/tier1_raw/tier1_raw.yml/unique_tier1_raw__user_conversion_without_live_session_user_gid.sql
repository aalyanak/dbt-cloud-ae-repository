
    
    

with dbt_test__target as (

  select user_gid as unique_field
  from `analytics-engineering-398318`.`ae_tier1_raw`.`user_conversion_without_live_session`
  where user_gid is not null

)

select
    unique_field,
    count(*) as n_records

from dbt_test__target
group by unique_field
having count(*) > 1


