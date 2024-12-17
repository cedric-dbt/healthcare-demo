with patients as (
    select
        extract(year from date_of_admission) as year,
        extract(month from date_of_admission) as month,
        count(*) as total_patients,
        avg(billing_amount) as avg_billing_amount,
        count(case when medication = 'Ibuprofen' then 1 end) as ibuprofen_prescriptions,
        count(case when medication = 'Aspirin' then 1 end) as aspirin_prescriptions,
        count(case when medication = 'Paracetamol' then 1 end) as paracetamol_prescriptions,
        count(case when medication = 'Acetaminophen' then 1 end) as acetaminophen_prescriptions
    from {{ ref('stg_raw__patient_data') }}
    group by 1, 2
),

sales as (
    select
        year,
        month,
        sum(total_hourly_ibuprofen_sales) as total_hourly_ibuprofen_sales,
        sum(total_hourly_acetaminophen_sales) as total_hourly_acetaminophen_sales,
        sum(total_hourly_aspirin_sales) as total_hourly_aspirin_sales,
        sum(total_hourly_paracetamol_sales) as total_hourly_paracetamol_sales,
        round(sum(total_daily_ibuprofen_sales), 2) as total_daily_ibuprofen_sales,
        round(sum(total_daily_acetaminophen_sales), 2) as total_daily_acetaminophen_sales,
        round(sum(total_daily_aspirin_sales), 2) as total_daily_aspirin_sales,
        round(sum(total_daily_paracetamol_sales), 2) as total_daily_paracetamol_sales
    from {{ ref('fct_aggregated_sales') }}
    group by 1, 2
)

select
    s.year,
    s.month,
    p.total_patients,
    p.avg_billing_amount,
    p.ibuprofen_prescriptions,
    p.acetaminophen_prescriptions,
    p.aspirin_prescriptions,
    p.paracetamol_prescriptions,
    s.total_hourly_ibuprofen_sales,
    s.total_hourly_acetaminophen_sales,
    s.total_hourly_aspirin_sales,
    s.total_hourly_paracetamol_sales,
    s.total_daily_ibuprofen_sales,
    s.total_daily_acetaminophen_sales,
    s.total_daily_aspirin_sales,
    s.total_daily_paracetamol_sales
from sales s
inner join patients p
    on s.year = p.year and s.month = p.month