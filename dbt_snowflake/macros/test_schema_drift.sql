{% test schema_drift(model, compare_model) %}
    {#
        Schema drift detection test.
        
        Ensures that two models have the same column structure (column names).
        Fails if there are any columns in one model that don't exist in the other.
        
        Args:
            model: The primary model to test (usually 'this' in schema.yml)
            compare_model: The model to compare against (e.g., ref('stg_nba_2425'))
        
        Usage in schema.yml:
            tests:
              - schema_drift:
                  compare_model: ref('stg_nba_2425')
        
        Example:
            - name: stg_nba_2324
              tests:
                - schema_drift:
                    compare_model: ref('stg_nba_2425')
    #}
    
    {%- set model_relation = model -%}
    {%- set compare_relation = compare_model -%}
    
    with model_columns as (
        select 
            lower(column_name) as column_name
        from {{ model_relation.database }}.information_schema.columns
        where table_schema = upper('{{ model_relation.schema }}')
          and table_name = upper('{{ model_relation.identifier }}')
    ),
    
    compare_columns as (
        select 
            lower(column_name) as column_name
        from {{ compare_relation.database }}.information_schema.columns
        where table_schema = upper('{{ compare_relation.schema }}')
          and table_name = upper('{{ compare_relation.identifier }}')
    ),
    
    model_only as (
        select 
            column_name,
            'missing_in_compare_model' as drift_type,
            '{{ model_relation }}' as model_name,
            '{{ compare_relation }}' as compare_model_name
        from model_columns
        where column_name not in (select column_name from compare_columns)
    ),
    
    compare_only as (
        select 
            column_name,
            'missing_in_model' as drift_type,
            '{{ model_relation }}' as model_name,
            '{{ compare_relation }}' as compare_model_name
        from compare_columns
        where column_name not in (select column_name from model_columns)
    ),
    
    schema_differences as (
        select * from model_only
        union all
        select * from compare_only
    )
    
    select * from schema_differences

{% endtest %}

