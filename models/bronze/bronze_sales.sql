{{ config(
    materialized='incremental',
    unique_key='sales_id',
    alias='sales_accounts',
) }}

select
    TO_HEX(SHA256(CAST(sales_agent as STRING))) as sale_id,
    sales_agent,
    TO_HEX(SHA256(CAST(manager as STRING))) as manager_id,
    manager,
    regional_office
from {{ source('crmhetic', 'team_sales') }}
