
    
    

with  __dbt__cte__stg_sources__sessions as (
with
    source as (select * from `analytics-engineering-398318`.`ae_sources`.`sessions`),

    session_final as (
        select distinct user_id, time_started, is_paid, medium from source
    )

select *
from session_final
), dbt_test__target as (

  select (user_id || '-' || time_started) as unique_field
  from __dbt__cte__stg_sources__sessions
  where (user_id || '-' || time_started) is not null

)

select
    unique_field,
    count(*) as n_records

from dbt_test__target
group by unique_field
having count(*) > 1


