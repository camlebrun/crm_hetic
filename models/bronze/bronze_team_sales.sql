{{ config(
    materialized='incremental',
    unique_key='sales_id',
    alias='team_sales',
) }}

select
    TO_HEX(SHA256(CAST(sales_agent as STRING))) as sale_id,
    sales_agent,
    manager,
    regional_office
from {{ source('crmhetic', 'team_sales') }}
