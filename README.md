## ELT and Data Analysis - london_bicycles
**Team members:** Alan, Daniel, Demi, Heng, Jasmine, Shern  

### 1. Data Ingestion
- Source data: [london_bicycles dataset](https://console.cloud.google.com/bigquery?ws=!1m4!1m3!3m2!1sbigquery-public-data!2slondon_bicycles)  
- Data warehouse: BigQuery

### 2. Data Warehouse Design
- Star schema
- Dimension tables: dim_station, dim_hire
- Fact table: fact_hire

### 3. ELT Pipeline
- DBT model *./models/fact_hire.sql*  
  - data filtering: *start_date>=yyyy, duration>0, start_station_id IS NOT NULL*
  - derived columns: *duration_minutes, time_of_day_category, season*
- DBT model *./models/star/dim_hire.sql* 
  - data filtering: *start_date>=yyyy*
  - derived columns: *start_total, end_total*
- DBT model *./models/star/dim_station.sql* 
  - data filtering: *start_date>=yyyy*

### 4. Data Quality Testing
- DBT model *./models/fact_hire.sql* implemented tests using dbt, *dbt_utils* and *dbt_expectations*
- 11 data tests for null values, duplicates, referential integrity and data type

### 5. Data Analysis with Python
- Aggregate data using SQL query in BigQuery
- Connect to data warehouse using SQLAlchemy to fetch desired tables
- Perform EDA using pandas and seaborn

### 6. Documentation
● Document your code, data lineage, and pipeline architecture using tools like DRAW.IO, EXCALIDRAW to illustrate the architecture of your data pipeline system
● Prepare a report summarizing the technical approach and your findings/insights, including relevant tables/charts/graphs
○ Explain why certain tools were chosen over others…etc
○ Explain why you decided to use your particular schema design and how it supports efficient querying (schema design justification)

### 7. Executive Stakeholder Presentation
Present the project's architecture, insights, and business recommendations to business and technical executives. This presentation should use the slide deck and, optionally, any interactive aids.
Recommended Components
● Executive Summary: Concise overview of the problem, solution, and business impact (2-3 minutes maximum)
● Business Value Proposition: Clear articulation of business value, efficiency improvements, and strategic alignment , driven by data and insights
● Technical Solution Overview: High-level system design with the ability to explain key technical decisions without overwhelming detail
● Risk and Mitigation: Honest assessment of technical risks, limitations, and mitigation strategies
● Q&A Handling: Confident, concise responses that demonstrate deep understanding while remaining accessible
Presentation Guidelines
● Duration: 10 minutes presentation + 5 minutes Q&A
● Audience: Assume a mixed audience of technical executives (CTOs, Engineering Directors) and business executives (CFOs, COOs, Business Leaders)
● Delivery: Recommend all team members to present and be prepared to answer questions
● Visuals: Use executive-friendly visuals (clear charts, architecture diagrams, ROI/KPI metrics), avoiding overly technical details
● Language: Balance technical credibility with business accessibility—avoid excessive jargon but demonstrate technical competence

### 8. Deliverables
1. GitHub repository in a single main branch with all code and documentation
2. Jupyter notebooks with basic analysis
3. Slide deck to present the executive summary and key findings  
  
### Ref:
- Gemini
- https://hub.getdbt.com/dbt-labs/dbt_utils/latest/, 
- https://hub.getdbt.com/calogica/dbt_expectations/latest/