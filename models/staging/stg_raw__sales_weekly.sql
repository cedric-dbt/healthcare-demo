with base as (
    select
        datum as sales_week_start,  -- Start of the sales week
        M01AB as weekly_ibuprofen_sales,
        M01AE as weekly_acetaminophen_sales,
        N02BA as weekly_aspirin_sales,
        N02BE as weekly_paracetamol_sales,
        N05B as weekly_antipsychotics_sales,
        N05C as weekly_anxiolytics_sales,
        R03 as weekly_respiratory_drugs_sales,
        R06 as weekly_antihistamines_sales
    from {{ source('raw', 'sales_weekly') }}
)

select *
from base