select
    avg(close_value) as avg_close_value,
    account_name
from {{ ref('silver_account_sales_profitability') }}
group by account_name
