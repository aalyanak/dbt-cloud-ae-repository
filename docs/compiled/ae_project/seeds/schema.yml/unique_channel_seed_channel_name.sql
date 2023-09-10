
    
    

with dbt_test__target as (

  select channel_name as unique_field
  from `analytics-engineering-398318`.`ae_sources`.`channel_seed`
  where channel_name is not null

)

select
    unique_field,
    count(*) as n_records

from dbt_test__target
group by unique_field
having count(*) > 1


