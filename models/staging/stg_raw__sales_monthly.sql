with base as (
    select
        datum as sales_month_start,  -- Start of the sales month
        M01AB as monthly_ibuprofen_sales,
        M01AE as monthly_acetaminophen_sales,
        N02BA as monthly_aspirin_sales,
        N02BE as monthly_paracetamol_sales,
        N05B as monthly_antipsychotics_sales,
        N05C as monthly_anxiolytics_sales,
        R03 as monthly_respiratory_drugs_sales,
        R06 as monthly_antihistamines_sales
    from {{ source('raw', 'sales_monthly') }}
)

select *
from base