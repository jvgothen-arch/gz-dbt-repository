with 

source as (

    select * from {{ source('gz_raw_data', 'ship') }}

),

renamed as (

    select
        orders_id,
        shipping_fee,
        
        logcost,
        CAST ((ship_cost) AS FLOAT64) as ship_cost_clean

    from source

)

select * from renamed