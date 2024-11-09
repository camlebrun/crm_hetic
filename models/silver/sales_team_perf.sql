with cte_sales as (
    select
        sale_id,
        sales_agent
    from {{ ref('bronze_sales') }}
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
)

select
    cte_orders.sale_id,
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
    on cte_sales.sale_id = cte_orders.sale_id
inner join cte_products
    on cte_orders.product_id = cte_products.product_id
