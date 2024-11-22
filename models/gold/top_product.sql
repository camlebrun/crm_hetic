select
    product,
    'N/A' as avg_sales_margin,
    count(*) as deals_won
from {{ ref('sales_team_perf') }}
where deal_stage = 'Won'
group by product
union all
select
    product,
    avg(sales_margin) as avg_sales_margin,
    count(*) as deals_won
from {{ ref('sales_team_perf') }}
where deal_stage = 'Won'
