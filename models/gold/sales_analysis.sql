select
sector,
count (*) as deals_won,
sum(close_value) as total_sales_revenues,
sum(sales_margin) as total_sales_margin
from {{ ref('sales_team_perf') }}
where deal_stage = 'Won'
group by sector