with player_season_compare as (

    select * 
    from {{ ref('int_nba_player_season_compare') }}

)

select
    player,
    team_2324,
    position_2324,
    age_2324,
    minutes_2324,
    team_2425,
    position_2425,
    age_2425,
    minutes_2425,
    threepfg_pct_2324,
    threepfg_pct_2425,
    -- Calculate the jump using reusable macro
    {{ calculate_yoy_shooting_change('threepfg_pct_2324', 'threepfg_pct_2425') }} as threepfg_pct_jump
from player_season_compare
where 
    -- Ensure both seasons have non-null 3P%
    threepfg_pct_2324 is not null
    and threepfg_pct_2425 is not null
    -- Optional: Only return meaningful/minute-qualified results
    and minutes_2324 > 500
    and minutes_2425 > 500
    and threepfg_pct_2324 > 0
    and threepfg_pct_2425 > 0
order by 
    threepfg_pct_jump desc