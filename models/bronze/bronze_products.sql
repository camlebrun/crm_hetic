{{ config(
    materialized='incremental',
    unique_key='product_id',
    alias='bronze_products',
) }}

select
    -- Utilisation de SHA256 et TO_HEX pour un identifiant stable en STRING
    TO_HEX(SHA256(CAST(product as STRING))) as product_id,
    product as product_name,
    series,
    sales_price
from {{ source('crmhetic', 'products') }}
