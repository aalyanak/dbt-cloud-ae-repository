
    
    

with dbt_test__target as (

  select (user_id || '-' || user_conversion_indicator) as unique_field
  from `analytics-engineering-398318`.`ae_tier3_consumption`.`user`
  where (user_id || '-' || user_conversion_indicator) is not null

)

select
    unique_field,
    count(*) as n_records

from dbt_test__target
group by unique_field
having count(*) > 1


