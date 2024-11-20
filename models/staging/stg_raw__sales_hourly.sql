with base as (
    select 
        datum as sales_datetime, -- timestamp of the sale
        M01AB as ibuprofen_sales,
        M01AE as acetaminophen_sales,
        N02BA as aspirin_sales,
        N02BE as paracetamol_sales,
        N05B as antipsychotics_sales,
        N05C as anxiolytics_sales,
        R03 as respiratory_drugs_sales,
        R06 as antihistamines_sales,
        year,
        month,
        hour,
        weekday_name
    from {{ source('raw', 'sales_hourly') }}

)

select * from base