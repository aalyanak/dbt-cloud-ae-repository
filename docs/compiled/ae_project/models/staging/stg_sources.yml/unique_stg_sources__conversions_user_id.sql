
    
    

with  __dbt__cte__stg_sources__conversions as (
with source as (
    SELECT * FROM `analytics-engineering-398318`.`ae_sources`.`conversions`
),

conversion_final AS (
  SELECT DISTINCT
    user_id,
    registration_time
   from source
)

select * from conversion_final
), dbt_test__target as (

  select user_id as unique_field
  from __dbt__cte__stg_sources__conversions
  where user_id is not null

)

select
    unique_field,
    count(*) as n_records

from dbt_test__target
group by unique_field
having count(*) > 1


