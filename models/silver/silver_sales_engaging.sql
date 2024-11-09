{{ config(
    materialized='incremental',
    unique_key='opportunity_id'

) }}
 select
        opportunity_id,
        account_id,
        sale_id,
        product_id,
        product,
        engage_at,
        close_at,
        close_value,
        deal_stage
    from {{ ref('bronze_orders') }}
    where deal_stage = 'Engaging'
    and account is not null
    {% if is_incremental() %}
        and engage_at >= DATE_SUB(CURRENT_DATE, interval 1 day)
    {% endif %}
