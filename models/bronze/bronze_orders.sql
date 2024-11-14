{{ config(
    materialized='incremental',
    unique_key='opportunity_id',
    alias='orders'
) }}


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
    /*
        conseils:
        backoofice =
        - rajout champs blabla
        Prospecting_date
        */
    close_value
from {{ source('crmhetic', 'sales_pepline') }}
where
    account is not null
    {% if is_incremental() %}
        and
        deal_stage in ('Engaging', 'Prospecting')
    {% endif %}
