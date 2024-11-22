select 
"all" as product,
"all" as sector,
avg(close_value) as avg_sales_revenues
from {{ ref('sales_team_perf') }} 
group by product, sector
union all
select
product,
"all" as sector,

avg(close_value) as avg_sales_revenues
from {{ ref('sales_team_perf') }}
group by product, sector

union all
product,
sector,
avg(close_value) as avg_sales_revenues  
from {{ ref('sales_team_perf') }}
group by product, sector