{% macro calculate_yoy_shooting_change(old_value, new_value) %}
    {#
        Calculates year-over-year change in shooting percentage metrics.
        
        Args:
            old_value: The metric from the previous season (e.g., threepfg_pct_2324)
            new_value: The metric from the current season (e.g., threepfg_pct_2425)
        
        Returns:
            The absolute change (new - old) as a decimal.
            Handles null values gracefully.
        
        Example:
            {{ calculate_yoy_shooting_change('threepfg_pct_2324', 'threepfg_pct_2425') }}
            Results in: threepfg_pct_2425 - threepfg_pct_2324
    #}
    
    case 
        when {{ old_value }} is null or {{ new_value }} is null 
        then null
        else {{ new_value }} - {{ old_value }}
    end
    
{% endmacro %}

