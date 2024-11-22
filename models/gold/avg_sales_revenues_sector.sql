select

    sector,

    avg(close_value) as avg_sales_revenues
from {{ ref('sales_team_perf') }}
where deal_stage = 'Won'
group by sector
