
    
    

with all_values as (

    select
        user_conversion_via_session_indicator as value_field,
        count(*) as n_records

    from `analytics-engineering-398318`.`ae_tier2_curated`.`user_conversion`
    group by user_conversion_via_session_indicator

)

select *
from all_values
where value_field not in (
    True,False
)


