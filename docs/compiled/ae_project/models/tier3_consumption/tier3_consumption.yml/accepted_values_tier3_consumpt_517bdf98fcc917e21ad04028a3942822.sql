
    
    

with all_values as (

    select
        user_conversion_channel_name as value_field,
        count(*) as n_records

    from `analytics-engineering-398318`.`ae_tier3_consumption`.`user_conversion`
    group by user_conversion_channel_name

)

select *
from all_values
where value_field not in (
    'paid_click','paid_impression','organic_click','direct','other'
)


