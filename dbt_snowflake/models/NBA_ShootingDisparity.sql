-- dbt_snowflake/models/example/food_trucks.sql

select TOP 10 * 
from {{ source('NBA_SHOOTING', 'NBA_2425') }}
where "3PFG%" is not null
and MinutesPlayed > 500
order by "3PFG%" desc