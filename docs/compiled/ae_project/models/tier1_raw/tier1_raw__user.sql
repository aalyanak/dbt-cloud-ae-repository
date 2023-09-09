

WITH  __dbt__cte__stg_sources__sessions as (
with
    source as (select * from `analytics-engineering-398318`.`ae_sources`.`sessions`),

    session_final as (
        select distinct user_id, time_started, is_paid, medium from source
    )

select *
from session_final
),  __dbt__cte__stg_sources__conversions as (
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
), session_users as (
   select distinct user_id from __dbt__cte__stg_sources__sessions
),

conversion_users as (
   select distinct user_id, registration_time from __dbt__cte__stg_sources__conversions
),

all_users AS(
 SELECT 
  coalesce(c.user_id, s.user_id) as user_id,
  case when c.user_id is not null then true else false end as user_conversion_indicator,
  coalesce(c.registration_time, null) as user_conversion_timestamp
FROM  conversion_users c
full join session_users s on c.user_id = s.user_id )

select 
  sha256(concat(cast(user_id as STRING), cast(user_conversion_indicator as STRING))) as user_gid,
  user_id,
  user_conversion_indicator

from all_users