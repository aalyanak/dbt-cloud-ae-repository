
    
    

with dbt_test__target as (

  select (TO_BASE64(user_gid) || '-' || cast(user_session_start_timestamp as string)) as unique_field
  from `analytics-engineering-398318`.`ae_tier1_raw`.`user_session`
  where (TO_BASE64(user_gid) || '-' || cast(user_session_start_timestamp as string)) is not null

)

select
    unique_field,
    count(*) as n_records

from dbt_test__target
group by unique_field
having count(*) > 1


