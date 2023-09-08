with
    source as (select * from {{ source("sources", "sessions") }}),

    session_final as (
        select distinct user_id, time_started, is_paid, medium from source
    )

select *
from session_final
