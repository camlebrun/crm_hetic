select

    sector,
    round(countif(deal_stage = 'Won') / count(*), 2) as count
from {{ ref('sales_team_perf') }}
group by sector