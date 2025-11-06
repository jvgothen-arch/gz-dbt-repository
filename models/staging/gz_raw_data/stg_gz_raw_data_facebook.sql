with src as (
  select * from {{ source('gz_raw_data','facebook') }}
)

select
camPGN_name as campaign_name,
CAST (ads_cost AS FLOAT64) as ads_cost_clean,
* except(campGN_name, ads_cost)
from src