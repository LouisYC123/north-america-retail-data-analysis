# north-america-retail-data-analysis
ELT and Analysis of US Retail data 1992-2022, using Python & dbt.

## Summary
This repo demonstrates the power of dbt to quickly turn raw data into actionable insights using the ELT paradigm. Raw data is pulled from ```www.census.gov``` and loaded to a dockerized postgres database using Python. From there, dbt is used to clean and reshape the data into a usable format for analysis. A set of datamarts are then constructed to provide end-users with efficient access to specific subsets of the data.  

A jupyter notebook is provided to simulate BI Tool / Analyst access to these datamarts

## Interesting Features
- Usage of jinja loops to UNION multiple raw tables into a single source table  
- Usage of ```unpivot``` from the dbt_utils package  
- Usage of jinja templating for data cleaning  
- Usage of SQL window functions in various data marts  
- Usage of dbt tests for data quality maintenance  

## Prerequisites

 - Docker  

## Setup

Clone this repo, open up a terminal and run:

``` docker compose build && docker compose up ```

This will build images and spin up four containers

- postgres_container: postgres docker container
- pgadmin4_container: browser-based SQL IDE on localhost:5050 (usage is optional)
- python_el: python container to extract raw data from zip file and load to postgres db
- dbt: python container to host dbt

**Note:** This may take several minutes the first time you build the images.  

Once dbt run has completed (you will get an message from the dbt container stating  ```Done``` ), you can work inside the dbt container ('attach container' if using VS Code)  

**Note:** Postgres 13 is the highest version you can use here due to an issue with dbt and SCRAM in dockerised postgres on mac1. Until a fix is available, please stick with Postgres 13 as defined in the dockerfile  


### Useful dbt commands: 
run dbt:  
dbt --profiles-dir profiles run  

generate documentation:  
dbt --profiles-dir profiles docs generate  

view documentation via browser:  
dbt --profiles-dir profiles docs serve  
