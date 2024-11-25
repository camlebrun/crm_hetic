select
sector,
count (*) as deals_won,
sum(close_value- sales_price) as total_sales_margin
from {{ ref('sales_team_perf') }}
where deal_stage = 'Won'
group by sector