{% docs __overview__ %}
# Welcome to the User Data Model of AE
This dbt project is a worked example to demonstrate how to model users and requested data over their sessions / conversions. 

The requirement of this project:
*We’re working with the Growth analytics team to improve how we attribute user sign ups to our acquisition channels and we want to use custom rules to define which channel should be awarded the credit for a given conversion. We will want to run this attribution model on a daily basis to track our acquisition channel results and we will also continue iterating on the model logic over time.*

This is the initiative requirement which kicked off this project. However, in future, we'd like to extend this model into a broader data warehouse. Therefore, the data is already modelled as a **User (also known as Customer/Campaign Contact/Client etc.)** -data model, and **User Conversion** is designed as a target domain.

Following business rules are applied to the **User Conversion Target Domain** logic:
- Channel *Paid Click* = If a session is initiated by a paid (is_paid=True) search medium (medium='PAID SEARCH'). This channel is a Prio-1 channel with a lifespan of 3 hours, which means that if a conversion happened within a 3-hour timeframe after a Paid Click, then the session is the winner.

- Channel *Paid Impression* = If a session is initiated by a paid (is_paid=True) social or display medium (medium in ('PAID SOCIAL', 'DISPLAY')). This channel is a Prio-1 channel with a lifespan of 1 hours, which means that if a conversion happened within a 1-hour timeframe after a Paid Impression, then the session is the winner.
>*NOTE: Paid Impression and Paid Social channels have the same priority, so the first session in timespan is the winner for conversion.*

- Channel *Organic Click* = If a session is initiated by a non-paid (is_paid=False) organic search medium (medium = 'ORGANIC SEARCH'). This channel is a Prio-2 channel with a lifespan of 12 hours, which means that if a conversion happened within a 12-hour timeframe after an Organic Click, and if no Prio-1 wins happened during this timeframe, then the session is the winner.

- Channel *Direct* = If a session not initiated by a Paid or Organic (Prio 1 or 2) session, but a non-paid (is_paid=False) direct medium (medium = 'DIRECT'). This channel is Prio-3.

- Channel *Other* = If a session not initiated any of the channels above. This channel is Prio-4. It can be either initiated by a session, or not.

##
A three-tier data model is designed with following specifications to host the User data:

>*(Note: On top of tier1, we also have the sources/seeds and staging models staging models which has 1-1 relationship to the source data.)*
- **Tier1 (Raw/Standardized Data Layer):** This tier includes a standardized/normalized relational data model, which contains the source attributes.
- **Tier2 (Integrated/Curated Layer):** This tier creates consumable data sets according to the business rules and definitions. Any calculation or pivoting can also be done on this layer, up to the curation is finalized, supporting entities can also be included.
- **Tier3 (Ready for Reporting/Consumption Layer):** This layer is the final layer of the model, which contains the production quality data and ready to be sent/connected to the target application.

Some notes about the project:

- The term "conversion" is oftenly used. This means, the user is signed up to the website, so a proof of acquisition.
- The locations of DRY (don't repeat yourself) code source files:
    - In *dbt_project.yml* file, you can find the variables used in models.
    - In *models/shared_definitions.md* file, you can find the code blocks of shared definitions used in yml files.

...

Check out an example report created by the consumption (tier3) layer data of this project [here](https://lookerstudio.google.com/u/0/reporting/e3a2ff77-80b8-4254-ba4a-9e105acccd13/page/hm9bD)

{% enddocs %}
