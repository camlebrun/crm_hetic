
select
    product,
    avg(close_value- sales_price) as avg_sales_margin,
    count(*) as deals_won
from {{ ref('sales_team_perf') }}
where deal_stage = 'Won'
group by product