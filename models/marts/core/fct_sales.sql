with hourly as (
    select
        date_trunc('day', sales_datetime) as sales_date,
        sum(ibuprofen_sales) as total_hourly_ibuprofen_sales,
        sum(acetaminophen_sales) as total_hourly_acetaminophen_sales,
        sum(aspirin_sales) as total_hourly_aspirin_sales,
        sum(paracetamol_sales) as total_hourly_paracetamol_sales
    from {{ ref('stg_raw__sales_hourly') }}
    group by 1
),

daily as (
    select
        sales_date,
        sum(daily_ibuprofen_sales) as total_daily_ibuprofen_sales,
        sum(daily_acetaminophen_sales) as total_daily_acetaminophen_sales,
        sum(daily_aspirin_sales) as total_daily_aspirin_sales,
        sum(daily_paracetamol_sales) as total_daily_paracetamol_sales
    from {{ ref('stg_raw__sales_daily') }}
    group by 1
),

weekly as (
    select
        date_trunc('week', sales_week_start) as sales_week,
        sum(weekly_ibuprofen_sales) as total_weekly_ibuprofen_sales,
        sum(weekly_acetaminophen_sales) as total_weekly_acetaminophen_sales,
        sum(weekly_aspirin_sales) as total_weekly_aspirin_sales,
        sum(weekly_paracetamol_sales) as total_weekly_paracetamol_sales
    from {{ ref('stg_raw__sales_weekly') }}
    group by 1
),

monthly as (
    select
        date_trunc('month', sales_month_start) as sales_month,
        sum(monthly_ibuprofen_sales) as total_monthly_ibuprofen_sales,
        sum(monthly_acetaminophen_sales) as total_monthly_acetaminophen_sales,
        sum(monthly_aspirin_sales) as total_monthly_aspirin_sales,
        sum(monthly_paracetamol_sales) as total_monthly_paracetamol_sales
    from {{ ref('stg_raw__sales_monthly') }}
    group by 1
)

select
    h.sales_date,
    h.total_hourly_ibuprofen_sales,
    d.total_daily_ibuprofen_sales,
    w.total_weekly_ibuprofen_sales,
    m.total_monthly_ibuprofen_sales
from hourly h
left join daily d on h.sales_date = d.sales_date
left join weekly w on date_trunc('week', h.sales_date) = w.sales_week
left join monthly m on date_trunc('month', h.sales_date) = m.sales_month