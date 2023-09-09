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