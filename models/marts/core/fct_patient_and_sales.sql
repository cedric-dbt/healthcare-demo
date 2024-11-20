with patients as (
    select
        extract(year from date_of_admission) as year,
        extract(month from date_of_admission) as month,
        count(*) as total_patients,
        avg(billing_amount) as avg_billing_amount,
        count(case when medication = 'Ibuprofen' then 1 end) as ibuprofen_prescriptions,
        count(case when medication = 'Aspirin' then 1 end) as aspirin_prescriptions,
        count(case when medication = 'Paracetamol' then 1 end) as pareacetamol_prescriptions
    from {{ ref('stg_raw__patient_data') }}
    group by year, month
),

sales as (
    select
        year,
        month,
        sum(total_hourly_ibuprofen_sales) as total_hourly_ibuprofen_sales,
        round(sum(total_daily_ibuprofen_sales), 2) as total_daily_ibuprofen_sales,
        round(sum(total_weekly_ibuprofen_sales), 2) as total_weekly_ibuprofen_sales,
        round(sum(total_monthly_ibuprofen_sales), 2) as total_monthly_ibuprofen_sales
    from {{ ref('fct_aggregated_sales') }}
    group by year, month
)

select
    s.year,
    s.month,
    s.total_hourly_ibuprofen_sales,
    s.total_daily_ibuprofen_sales,
    s.total_weekly_ibuprofen_sales,
    s.total_monthly_ibuprofen_sales,
    p.total_patients,
    p.avg_billing_amount,
    p.ibuprofen_prescriptions,
    p.aspirin_prescriptions,
    p.pareacetamol_prescriptions
from sales s
join patients p
    on s.year = p.year and s.month = p.month