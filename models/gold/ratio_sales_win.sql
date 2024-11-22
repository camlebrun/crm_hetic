select
product,
"all" as sector,
round(countif(deal_stage ='Won')/count(*),2) as count,
from {{ ref('sales_team_perf') }}
group by product
union all 
select
"all" as product,
sector,
round(countif(deal_stage ='Won')/count(*),2) as count,
from {{ ref('sales_team_perf') }}
group by product, sector

union all 
select
product,
sector,
round(countif(deal_stage ='Won')/count(*),2) as count,
from {{ ref('sales_team_perf') }}
group by product, sector