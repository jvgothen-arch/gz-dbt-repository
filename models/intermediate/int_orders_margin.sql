 {{ config(materialized="view") }}
 
 
 with
sales as (
  select * from {{ ref('stg_raw__sales') }}
),
product as (
  select * from {{ ref('stg_gz_raw_data__product') }}
),

joined as (
  select
    s.date_date,
    s.orders_id,
    s.products_id,
    s.revenue,
    s.quantity,
    p.products_id,
    p.purchase_price,

    (s.quantity * p.purchase_price) as purchase_cost,
   ROUND((s.revenue - (s.quantity * p.purchase_price)),2) as margin

  from sales s
  left join product p
    on s.products_id = p.products_id
)


SELECT
     orders_id,
     date_date,
     ROUND(SUM(revenue),2) as revenue,
     ROUND(SUM(quantity),2) as quantity,
     ROUND(SUM(purchase_cost),2) as purchase_cost,
     ROUND(SUM(margin),2) as margin
 FROM {{ ref("int_sales_margin") }}
 GROUP BY orders_id,date_date
 ORDER BY orders_id DESC
