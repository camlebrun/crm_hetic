select round(countif(deal_stage = 'Lost') / count(*), 2) as count
from {{ ref('sales_team_perf') }}
