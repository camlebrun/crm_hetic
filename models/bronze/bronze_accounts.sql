{{ config(
    materialized='incremental',
    unique_key='account_id',
    alias='clients_account',
) }}

select
    TO_HEX(SHA256(CAST(account as STRING))) as account_id,
    account as account_name,
    sector,
    year_established as year_founded_at,
    revenue,
    employees as number_of_employees,
    office_location,
    subsidiary_of
from {{ source('crmhetic', 'accounts') }}
