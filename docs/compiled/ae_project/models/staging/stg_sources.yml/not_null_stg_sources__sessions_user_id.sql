
    
    



with __dbt__cte__stg_sources__sessions as (
with
    source as (select * from `analytics-engineering-398318`.`ae_sources`.`sessions`),

    session_final as (
        select distinct user_id, time_started, is_paid, medium from source
    )

select *
from session_final
) select user_id
from __dbt__cte__stg_sources__sessions
where user_id is null


