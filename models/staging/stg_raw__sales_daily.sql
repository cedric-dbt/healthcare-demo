with base as (
    select
        datum as sales_date, -- original date
        M01AB as daily_ibuprofen_sales,
        M01AE as daily_acetaminophen_sales,
        N02BA as daily_aspirin_sales,
        N02BE as daily_paracetamol_sales,
        N05B as daily_antipsychotics_sales,
        N05C as daily_anxiolytics_sales,
        R03 as daily_respiratory_drugs_sales,
        R06 as daily_antihistamines_sales,
        year,
        month,
        weekday_name
    from {{ source('raw', 'sales_daily') }}
)

select *
from base