select
    product,

    avg(sales_cycle_days) as avg_time_to_close_in_days
from `crmhetic.silver.sales_profitability`
where deal_stage = 'Won'
group by product
