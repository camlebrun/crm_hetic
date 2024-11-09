{{ config(
    materialized='incremental',
    unique_key='opportunity_id',
    alias='orders'
) }}

with base_data as (
    select
        opportunity_id,
        TO_HEX(SHA256(CAST(sales_agent as STRING))) as sale_id,
        sales_agent,
        TO_HEX(SHA256(CAST(product as STRING))) as product_id,
        product,
        TO_HEX(SHA256(CAST(account as STRING))) as account_id,
        account,
        deal_stage,
        engage_date as engage_at,
        close_date as close_at,
        close_value
    from {{ source('crmhetic', 'sales_pepline') }}
)

select
    opportunity_id,
    sale_id,
    sales_agent,
    product_id,
    product,
    account_id,
    account,
    deal_stage,
    engage_at,
    close_at,
    close_value
from base_data

{% if is_incremental() %}
    where
        deal_stage in ('Engaging', 'Prospecting')
{% endif %}
