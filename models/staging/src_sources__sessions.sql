with source as (
    SELECT * FROM {{ source('sources', 'sessions') }}
),

session_final AS (
  SELECT DISTINCT
    user_id,
    time_started,
    is_paid,
    medium
   from source
)

select * from session_final
