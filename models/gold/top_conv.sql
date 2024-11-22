select

    round((countif(deal_stage = 'Won') / count(*)), 2) as ratio_win,
    sales_agent
from {{ ref('sales_team_perf') }}
group by sales_agent
order by ratio_win desc
