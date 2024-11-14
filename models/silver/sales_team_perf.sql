{{ config(
    materialized='table',
    unique_key='opportunity_id',
    alias='account_client_profitability'
) }}



with cte_sales as (
    select
        account_id,
        account_name, 
        sector,
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
        close_value
    from {{ ref('bronze_orders') }}
    where account_id is not null and deal_stage = 'Won'
)

select
    cte_orders.account_id,
    cte_sales.account_name,
    cte_sales.sector,
    cte_orders.product_id,
    cte_orders.product,
    cte_orders.engage_at,
    cte_orders.close_at,
    cte_orders.sales_cycle_days,
    cte_orders.close_value,
    cte_products.sales_price,
    (cte_orders.close_value - cte_products.sales_price) as sales_margin
from cte_sales
inner join cte_orders
    on cte_sales.account_id = cte_orders.account_id
inner join cte_products
    on cte_orders.product_id = cte_products.product_id
