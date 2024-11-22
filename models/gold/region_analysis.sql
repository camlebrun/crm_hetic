select
    region,
    count(*) as total_sales,
    countif(deal_stage = 'Won') as total_wins,
    round(countif(deal_stage = 'Won') / count(*), 2) as ratio_wins,
    avg(close_value) as avg_sales_revenues
from {{ ref('sales_team_perf') }}
