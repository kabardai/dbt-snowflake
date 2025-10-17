with source as (

    select * from {{ source('NBA_SHOOTING', 'NBA_2324') }}

),

renamed as (

    select
        cast("RK" as number)                as rk,
        cast("PLAYER" as varchar)           as player,
        cast("AGE" as number)               as age,
        cast("TEAM" as varchar)             as team,
        cast("POSITION" as varchar)         as position,
        cast("GAMESPLAYED" as number)       as games_played,
        cast("GAMESSTARTED" as number)      as games_started,
        cast("MINUTESPLAYED" as number)     as minutes_played,
        cast("FG%" as number(5,3))          as fg_pct,
        cast("Dist." as number(5,3))        as avg_dist,
        cast("2PA%" as number(5,3))         as twopa_pct,
        cast("2PFG%" as number(5,3))        as twopfg_pct,
        cast("2PASS%" as number(5,3))       as twopass_pct,
        cast("3PA%" as number(5,3))         as threepa_pct,
        cast("3PFG%" as number(5,3))        as threepfg_pct,
        cast("3PASS%" as number(5,3))       as threepass_pct,
        cast("0-3A%" as number(5,3))        as rim_attempt_pct,
        cast("0-3FG%" as number(5,3))       as rim_fg_pct,
        cast("3-10A%" as number(5,3))       as short_mid_attempt_pct,
        cast("3-10FG%" as number(5,3))      as short_mid_fg_pct,
        cast("10-16A%" as number(5,3))      as long_mid_attempt_pct,
        cast("10-16FG%" as number(5,3))     as long_mid_fg_pct,
        cast("16-3PA%" as number(5,3))      as deep2_attempt_pct,
        cast("16-3PFG%" as number(5,3))     as deep2_fg_pct,
        cast("%FGADUNK" as number(5,3))     as pct_fga_dunk,
        cast("DUNKS" as number)             as dunks,
        cast("%3PACORNER" as number(5,3))   as pct_3pa_corner,
        cast("3P%CORNER" as number(5,3))    as threep_corner_pct,
        cast("HEAVEATTEMPT" as number)      as heave_attempt,
        cast("HEAVEMADE" as number)         as heave_made
    from source

)

select * from renamed