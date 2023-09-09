
    
    

with child as (
    select user_session_gid as from_field
    from `analytics-engineering-398318`.`ae_tier1_raw`.`user_conversion_organic_live_session`
    where user_session_gid is not null
),

parent as (
    select user_session_gid as to_field
    from `analytics-engineering-398318`.`ae_tier1_raw`.`user_session`
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


