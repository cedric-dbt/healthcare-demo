with base as (
    select
        extract(year from date_of_admission) as year,
        extract(month from date_of_admission) as month,
        count(*) as total_patients,
        round(avg(billing_amount), 2) as avg_billing_amount,
        sum(billing_amount) as total_patient_revenue,  -- Total revenue calculation
        count(case when medication = 'Ibuprofen' then 1 end) as ibuprofen_prescriptions,
        count(case when medication = 'Aspirin' then 1 end) as aspirin_prescriptions,
        count(case when medication = 'Paracetamol' then 1 end) as paracetamol_prescriptions  -- Fixed typo
    from {{ ref('stg_raw__patient_data') }}
    group by year, month
)

select * from base