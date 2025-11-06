with fin as (
  select
    date_trunc(date_date, month)                 as datemonth,
    round(sum(revenue), 2)                       as revenue,
    round(sum(margin), 2)                        as margin,
    round(sum(operational_margin), 2)            as operational_margin,
    round(sum(purchase_cost), 2)                 as purchase_cost,
    round(sum(shipping_fee), 2)                  as shipping_fee,
    round(sum(log_cost), 2)                      as log_cost,
    round(sum(ship_cost), 2)                     as ship_cost,
    sum(quantity)                                as quantity,
    round(avg(average_basket), 2)                as average_basket
  from {{ ref('finance_days') }}
  group by datemonth
),
ads as (
  select
    date_trunc(date_date, month)                 as datemonth,
    round(sum(ads_cost_clean), 2)                as ads_cost,
    sum(impression)                             as ads_impression,
    sum(click)                                  as ads_clicks
  from {{ ref('int_campaigns_day') }}
  group by datemonth
)

select
  f.datemonth,
  round((f.operational_margin) - (a.ads_cost), 2) as ads_margin,
  f.average_basket,
  f.operational_margin,
  a.ads_cost,
  a.ads_impression,
  a.ads_clicks,
  f.quantity,
  f.revenue,
  f.margin,
  f.purchase_cost,
  f.shipping_fee,
  f.log_cost,
  f.ship_cost
from fin f
left join ads a using (datemonth)
order by datemonth desc