with src as (
  select * from {{ ref('int_campaigns') }}
)
select
  date_date,
  campaign_name,
  paid_source,
  round(sum(ads_cost_clean), 2)  as ads_cost_clean,
  click,
  impression

from src
group by date_date, campaign_name, paid_source, click, impression

order by date_date desc