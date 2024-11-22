select
    sales_agent,
    count(*) as deals_won
from {{ ref('sales_team_perf') }}
where deal_stage = 'Won'
group by sales_agent
