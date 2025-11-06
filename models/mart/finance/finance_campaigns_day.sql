with ads_by_day as (
  select
    date_date,
    round(sum(ads_cost_clean), 2) as ads_cost
  from {{ ref('int_campaigns_day') }}
  group by date_date
),

fin as (
  select * from {{ ref('finance_days') }}
)

select
  f.date_date,
  f.revenue,
  f.margin,
  f.operational_margin,
  f.purchase_cost,
  f.shipping_fee,
  f.log_cost,
  f.ship_cost,
  f.quantity,
  f.average_basket,
  a.ads_cost,

  round((f.operational_margin) - (a.ads_cost), 2) as ads_margin
from fin f
left join ads_by_day a
  using (date_date)
order by f.date_date desc