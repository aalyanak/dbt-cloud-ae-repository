
    
    



with __dbt__cte__stg_sources__sessions as (
with
    source as (select * from `analytics-engineering-398318`.`ae_sources`.`sessions`),

    session_final as (
        select distinct user_id, time_started, is_paid, medium from source
    )

select *
from session_final
) select time_started
from __dbt__cte__stg_sources__sessions
where time_started is null


