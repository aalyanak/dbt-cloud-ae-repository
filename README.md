## Hi! Welcome to the AE Project! 


This project includes a set of models to create the User data model.

#### Design: 
A three-tier data model is designed with following specifications to host the User data:

*(Note: On top of tier1, we also have the sources/seeds and staging models staging models which has 1-1 relationship to the source data.)*
- **Tier1 (Raw/Standardized Data Layer):** This tier includes a standardized/normalized relational data model, which contains the source attributes.
- **Tier2 (Integrated/Curated Layer):** This tier creates consumable data sets according to the business rules and definitions. Any calculation or pivoting can also be done on this layer, up to the curation is finalized, supporting entities can also be included.
- **Tier3 (Ready for Reporting/Consumption Layer):** This layer is the final layer of the model, which contains the production quality data and ready to be sent/connected to the target application.

#### To reproduce the results via a different dataset:
Please change the "sources" configuration in [*models/staging/stg_sources.yml*](https://github.com/aalyanak/dbt-cloud-ae-repository/blob/main/models/staging/stg_sources.yml)  file.

```
sources:
  - name: sources
    database: analytics-engineering-398318
    schema: ae_sources
tables:
      - name: sessions
.
.
      - name: conversions
```

#### The locations of DRY (don't repeat yourself) code source files:
- In [*dbt_project.yml*](https://github.com/aalyanak/dbt-cloud-ae-repository/blob/main/dbt_project.yml) file, you can find the variables used in models.
- In [*models/shared_definitions.md*](https://github.com/aalyanak/dbt-cloud-ae-repository/blob/main/models/shared_definitions.md) file, you can find the code blocks of shared definitions used in yml files.

Try running the following commands:
- **dbt build** (or dbt seed + dbt test + dbt run) to regenerate the entire model
- **dbt docs generate** to regenerate the documentation

### Resources:
- GitHub link of this repository: [click](https://github.com/aalyanak/dbt-cloud-ae-repository/tree/main)
- Check out the ERD diagrams of the data model: [click](https://miro.com/app/board/uXjVMnUZ8Nk=/?share_link_id=331262939098)
- Check out the DBT docs: [click](https://aalyanak.github.io/dbt-cloud-ae-repository/#!/overview) for extensive information of each tables and columns
- The linked data lake: [click](https://console.cloud.google.com/bigquery?project=analytics-engineering-398318)
- And lastly, check an example report which is created on tier3 data: [click](https://lookerstudio.google.com/u/0/reporting/e3a2ff77-80b8-4254-ba4a-9e105acccd13/page/hm9bD)