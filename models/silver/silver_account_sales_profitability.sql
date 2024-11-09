{{ config(
    materialized='incremental',
    unique_key='account_id',
    alias='sales_profitability'
) }}

with cte_accounts as (
    select
        account_id,
        account_name,
        sector,
        year_founded_at,
        office_location,
        revenue
    from {{ ref('bronze_accounts') }}
),

cte_products as (
    select
        product_id,
        product_name,
        series,
        sales_price
    from {{ ref('bronze_products') }}
),

cte_orders as (
    select
        opportunity_id,
        account_id,
        sale_id,
        product_id,
        product,
        engage_at,
        close_at,
        date_diff(close_at, engage_at, day) as sales_cycle_days,
        close_value,
        deal_stage
    from {{ ref('bronze_orders') }}
)

select
    cte_accounts.account_id,
    cte_accounts.account_name,
    cte_accounts.sector,
    cte_accounts.year_founded_at,
    cte_accounts.office_location,
    cte_accounts.revenue,
    cte_orders.sale_id,
    cte_orders.product_id,
    cte_orders.product,
    cte_orders.engage_at,
    cte_orders.close_at,
    cte_orders.sales_cycle_days,
    cte_orders.close_value,
    cte_products.sales_price,
    cte_orders.deal_stage,
    (cte_orders.close_value - cte_products.sales_price) as sales_margin
from cte_accounts
inner join cte_orders
    on cte_accounts.account_id = cte_orders.account_id
inner join cte_products
    on cte_orders.product_id = cte_products.product_id
