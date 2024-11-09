{{ config(
    materialized='incremental',
    unique_key='account_id',
    alias='accounts'
) }}
select 
md5(account) as account_id, 
account as account_name, 
sector, 
year_established as year_founded_at,
revenue,
employees as number_of_employees,
office_location,
subsidiary_of

FROM {{ source('crmhetic', 'accounts') }}