-- dbt_snowflake/models/NBA_ShootingDIsparity.sql

SELECT
    COALESCE(a.Player, b.Player) AS Player,
    a."3PFG%" AS FG3_2324,
    b."3PFG%" AS FG3_2425,
    b."3PFG%" - a."3PFG%" AS FG3_Change
FROM
    {{ source('NBA_SHOOTING', 'NBA_2324') }} a
FULL OUTER JOIN
    {{ source('NBA_SHOOTING', 'NBA_2425') }} b
    ON a.Player = b.Player
WHERE 
    a."3PFG%" IS NOT NULL
    AND b."3PFG%" IS NOT NULL
    and a.MinutesPlayed > 500
    and b.MinutesPlayed > 500
    and a."3PFG%" > 0
    and b."3PFG%" > 0
ORDER BY
    FG3_Change DESC 