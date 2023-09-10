
    
    

with dbt_test__target as (

  select user_id as unique_field
  from `analytics-engineering-398318`.`ae_tier2_curated`.`user_conversion`
  where user_id is not null

)

select
    unique_field,
    count(*) as n_records

from dbt_test__target
group by unique_field
having count(*) > 1


