{{ config(
    materialized='table',
) }}

with agent_count_per_account as (
    select
        account_name,
        COUNT(distinct sales_agent) as distinct_agent_count
    from
        {{ ref('sales_team_perf') }}

    group by
        account_name
),

top_sales_agent_per_account as (
    select
        account_name,
        sales_agent,
        SUM(close_value) as total_profit,
        ROW_NUMBER()
            over (partition by account_name order by SUM(close_value) desc)
            as rank
    from
        {{ ref('sales_team_perf') }}
    group by
        account_name, sales_agent
)

select
    t.account_name,
    t.sales_agent as top_sales_agent,
    t.total_profit
from
    top_sales_agent_per_account ats 
inner join
    agent_count_per_account as a
    on t.account_name = a.account_name
where
    a.distinct_agent_count > 1
    and t.rank = 1
