{{
    config(
        materialized='incremental',
        unique_key='player_season_key',
        incremental_strategy='merge'
    )
}}

-- EXAMPLE: Incremental model that adds new seasons as they become available
-- 
-- HOW IT WORKS:
-- - First run: Builds full table with all available seasons
-- - Next run: Only processes NEW seasons (2025-2026, 2026-2027, etc.)
-- - Uses MERGE strategy to update existing rows or insert new ones
--
-- COMMANDS:
-- - dbt run --select mart_nba_all_seasons  (incremental run)
-- - dbt run --select mart_nba_all_seasons --full-refresh  (rebuild from scratch)

with all_seasons as (
    
    select
        player,
        '2023-2024' as season,
        team,
        position,
        minutes_played,
        threepfg_pct,
        twopfg_pct,
        fg_pct
    from {{ ref('stg_nba_2324') }}
    where minutes_played > 500
    
    union all
    
    select
        player,
        '2024-2025' as season,
        team,
        position,
        minutes_played,
        threepfg_pct,
        twopfg_pct,
        fg_pct
    from {{ ref('stg_nba_2425') }}
    where minutes_played > 500
    
    -- When 2025-2026 season data arrives, just add:
    -- union all
    -- select ... from {{ ref('stg_nba_2526') }}
)

select
    -- Unique key: player + season (ensures one row per player per season)
    player || '_' || season as player_season_key,
    player,
    season,
    team,
    position,
    minutes_played,
    threepfg_pct,
    twopfg_pct,
    fg_pct,
    current_timestamp() as _dbt_updated_at

from all_seasons

{% if is_incremental() %}
    -- On incremental runs, only process seasons that don't already exist
    -- {{ this }} refers to the current model (the table being built)
    where season > (select max(season) from {{ this }})
    

{% endif %}

