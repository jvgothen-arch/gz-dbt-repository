with source as (
  select * from {{ source('gz_raw_data', 'product') }}
),
clean as (
  select
    products_id,
   
    CAST((purchse_price) AS FLOAT64) as purchase_price
  from source
)
select * from clean