

WITH user_conversion AS (
    select * from `analytics-engineering-398318`.`ae_tier2_curated`.`user_conversion`
)
select 
    user_id,
    user_conversion_indicator,
    user_conversion_channel_name,
    user_conversion_timestamp,
    user_conversion_via_session_indicator
from user_conversion