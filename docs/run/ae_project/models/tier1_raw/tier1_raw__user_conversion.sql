
  
    

    create or replace table `analytics-engineering-398318`.`ae_tier1_raw`.`user_conversion`
      
    
    

    OPTIONS()
    as (
      

WITH  __dbt__cte__stg_sources__conversions as (
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
), users as (
    select * from `analytics-engineering-398318`.`ae_tier1_raw`.`user`
    where user_conversion_indicator=true),

conversion as (
    select * from __dbt__cte__stg_sources__conversions
),

user_conversion as (
    select 
    u.user_gid,
    c.registration_time as user_conversion_timestamp
    from users u
    inner join conversion c on u.user_id=c.user_id
)

select * from user_conversion
    );
  