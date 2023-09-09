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

{% docs def_ent_user_conversion %}
User Conversion contains the users who are converted (signed up) to the website.
{% enddocs %}

## Shared Definitions - Attributes

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

{% docs def_att_session_start_time %}
is the time when the session is started.
{% enddocs %}

{% docs def_att_session_end_time %}
is the time when the session is ended.
{% enddocs %}

{% docs def_att_session_channel %}
is the name of the channel which initiated the session.
{% enddocs %}


## Shared Definitions - UDP

{% docs def_udp_channel_prio %}
An ascending number of the priority order (from highest to lowest) of the channel, according to the business logic:
    * The paid channels (click or impression) have the highest priority (1), as they also have ability of hijacking.
    * The organic clicks has the second order of priority (2).
    * Direct channel has the third order of priority (3).
    * Other mediums have the last (4).
{% enddocs %}