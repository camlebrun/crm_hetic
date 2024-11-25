select
    sales_agent,
    sum(close_value- sales_price) as total_sales_margin
from {{ ref('sales_team_perf') }}
where deal_stage = 'Won'
group by sales_agent
