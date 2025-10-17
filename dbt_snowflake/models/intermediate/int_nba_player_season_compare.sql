with s2324 as (
    select
        player,
        team as team_2324,
        position as position_2324,
        age as age_2324,
        minutes_played as minutes_2324,
        threepfg_pct as threepfg_pct_2324,
        threepa_pct as threepa_pct_2324,
        twopfg_pct as twopfg_pct_2324,
        twopa_pct as twopa_pct_2324,
        rim_attempt_pct as rim_attempt_pct_2324,
        rim_fg_pct as rim_fg_pct_2324,
        short_mid_attempt_pct as short_mid_attempt_pct_2324,
        short_mid_fg_pct as short_mid_fg_pct_2324,
        long_mid_attempt_pct as long_mid_attempt_pct_2324,
        long_mid_fg_pct as long_mid_fg_pct_2324,
        deep2_attempt_pct as deep2_attempt_pct_2324,
        deep2_fg_pct as deep2_fg_pct_2324
    from {{ ref('stg_nba_2324') }}
),

s2425 as (
    select
        player,
        team as team_2425,
        position as position_2425,
        age as age_2425,
        minutes_played as minutes_2425,
        threepfg_pct as threepfg_pct_2425,
        threepa_pct as threepa_pct_2425,
        twopfg_pct as twopfg_pct_2425,
        twopa_pct as twopa_pct_2425,
        rim_attempt_pct as rim_attempt_pct_2425,
        rim_fg_pct as rim_fg_pct_2425,
        short_mid_attempt_pct as short_mid_attempt_pct_2425,
        short_mid_fg_pct as short_mid_fg_pct_2425,
        long_mid_attempt_pct as long_mid_attempt_pct_2425,
        long_mid_fg_pct as long_mid_fg_pct_2425,
        deep2_attempt_pct as deep2_attempt_pct_2425,
        deep2_fg_pct as deep2_fg_pct_2425
    from {{ ref('stg_nba_2425') }}
)

select
    coalesce(s2324.player, s2425.player) as player,
    
    -- 23-24 stats
    s2324.team_2324,
    s2324.position_2324,
    s2324.age_2324,
    s2324.minutes_2324,
    s2324.threepfg_pct_2324,
    s2324.threepa_pct_2324,
    s2324.twopfg_pct_2324,
    s2324.twopa_pct_2324,
    s2324.rim_attempt_pct_2324,
    s2324.rim_fg_pct_2324,
    s2324.short_mid_attempt_pct_2324,
    s2324.short_mid_fg_pct_2324,
    s2324.long_mid_attempt_pct_2324,
    s2324.long_mid_fg_pct_2324,
    s2324.deep2_attempt_pct_2324,
    s2324.deep2_fg_pct_2324,

    -- 24-25 stats
    s2425.team_2425,
    s2425.position_2425,
    s2425.age_2425,
    s2425.minutes_2425,
    s2425.threepfg_pct_2425,
    s2425.threepa_pct_2425,
    s2425.twopfg_pct_2425,
    s2425.twopa_pct_2425,
    s2425.rim_attempt_pct_2425,
    s2425.rim_fg_pct_2425,
    s2425.short_mid_attempt_pct_2425,
    s2425.short_mid_fg_pct_2425,
    s2425.long_mid_attempt_pct_2425,
    s2425.long_mid_fg_pct_2425,
    s2425.deep2_attempt_pct_2425,
    s2425.deep2_fg_pct_2425

from s2324
inner join s2425
    on s2324.player = s2425.player
where s2324.minutes_2324 > 500 and s2425.minutes_2425 > 500