with source as (
    SELECT * FROM {{ source('sources', 'conversions') }}
),

conversion_final AS (
  SELECT DISTINCT
    user_id,
    registration_time
   from source
)

select * from conversion_final