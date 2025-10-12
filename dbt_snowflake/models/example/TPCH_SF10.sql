-- dbt_snowflake/models/example/food_trucks.sql

select *
from {{ source('TPCH_SF10', 'CUSTOMER') }}