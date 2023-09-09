
    
    

with all_values as (

    select
        user_conversion_indicator as value_field,
        count(*) as n_records

    from `analytics-engineering-398318`.`ae_tier2_curated`.`user`
    group by user_conversion_indicator

)

select *
from all_values
where value_field not in (
    True,False
)


