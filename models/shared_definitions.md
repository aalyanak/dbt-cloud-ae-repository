## Shared Definitions - Entities

{% docs def_source_data %}
is a table of source data.  
- The data has been downloaded from shared Google Drive folder and loaded into BigQuery.  
- For remapping this source data into a different file, please change the credentials of database & schema in the "sources" configuration accordingly.
{% enddocs %}

{% docs def_staging_entity %}
is a staging entity for multiple use of the data source
{% enddocs %}

{% docs def_ent_user %}
A User is a name given to an individual who interacts with the website, either converted (signed up) or as a guest. For now, we only have converted users, but the model is extendable to the guest users in the future.
{% enddocs %}

{% docs def_ent_conversion %}
contains the users who are converted (signed up) to the website
{% enddocs %}

{% docs def_ent_session %}
contains the Users and their details which initiated a session on the website.
{% enddocs %}

{% docs def_ent_channel %}
is a collection of conversion channel names, their prioritization in conversation strategy and lifespan of channels (if applicable).
{% enddocs %}

## Shared Definitions - Attributes

{% docs def_att_user_gid %}
A User Gid is the generated surrogate key for a User. It's a composite key of User Id and User Conversion Indicator.
{% enddocs %}

{% docs def_att_user_id %}
A User Id is the unique identifier of a User.
{% enddocs %}

{% docs def_att_user_conversion_ind %}
A User Conversion Indicator indicates whether or not a User is converted (signed up).
{% enddocs %}

{% docs def_att_conversion_time %}
is the time when the conversion is happened.
{% enddocs %}

{% docs def_att_conversion_channel %}
is the name of the channel which is the winner for the conversion.
{% enddocs %}

{% docs user_conversion_via_session_ind %}
User Conversion via Session indicator indicates whether or not a User is conversion is initiated by a session (live or non-live).
{% enddocs %}

{% docs def_att_user_session_gid %}
A User Session Gid is the generated surrogate key for a User Session. It's a composite key of User Gid and User Session Start Time.
{% enddocs %}

{% docs def_att_session_start_time %}
is the time when the session is started by the User.
{% enddocs %}

{% docs def_att_session_end_time %}
is the time when the session is considered as ended (if applicable).
{% enddocs %}

{% docs def_att_session_channel %}
is the name of the channel which initiated the session.
{% enddocs %}

{% docs def_att_channel_gid %}
Channel Gid is the generated surrogate key for a Channel.
{% enddocs %}

{% docs def_att_channel_name %}
Channel Name is the name of the channel.
{% enddocs %}


## Shared Definitions - Extra Information

{% docs def_udp_channel_prio %}
An ascending number of the priority order (from highest to lowest) of the channel, according to the business logic:
    * The paid channels (click or impression) have the highest priority (1), as they also have ability of hijacking.
    * The organic clicks has the second order of priority (2).
    * Direct channel has the third order of priority (3).
    * Other mediums have the last (4).
{% enddocs %}

{% docs def_udp_channel_classification %}
There are some business rules applied for this channel grouping. To achieve this, channel_seed data is used as a base. And then, this channel seed is linked to sessions, to group them according to the rules:

    **(1.1) Channel Paid Click:** If a session is initiated by a paid (is_paid=True) search medium (medium='PAID SEARCH'). 
    This channel is a Prio-1 channel with a lifespan of 3 hours, which means that if a conversion happened within a 3-hour timeframe after a Paid Click, then the session is the winner.

    **(1.2) Channel Paid Impression:** If a session is initiated by a paid (is_paid=True) social or display medium (medium in ('PAID SOCIAL', 'DISPLAY')). 
    This channel is a Prio-1 channel with a lifespan of 1 hours, which means that if a conversion happened within a 1-hour timeframe after a Paid Impression, then the session is the winner.

    >> NOTE: Paid Impression and Paid Social channels have the same priority, so the first session in timespan is the winner for conversion.

    **(2) Channel Organic Click:** If a session is initiated by a non-paid (is_paid=False) organic search medium (medium = 'ORGANIC SEARCH'). 
    This channel is a Prio-2 channel with a lifespan of 12 hours, which means that if a conversion happened within a 12-hour timeframe after an Organic Click, and if no Prio-1 wins happened during this timeframe (as they have the ability to hijack), then the session is the winner.

    **(3) Channel Direct:** If a session is not initiated by a Paid or Organic (Prio 1 or 2) session, but a non-paid (is_paid=False) direct medium (medium = 'DIRECT'). This channel is Prio-3.

    **(4) Channel Other:** If a session is not initiated by any of the channels above. This channel is Prio-4. It can be either initiated by a session, or not. You can discriminate this by user_conversion.user_conversion_via_session_indicator.
{% enddocs %}