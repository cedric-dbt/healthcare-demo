with base as (
    select
        *
    from {{ source('raw', 'patient_data') }}
)

select 
    upper(name) as name,
    age,
    gender,
    blood_type,
    medical_condition,
    date_of_admission,
    doctor,
    hospital,
    insurance_provider,
    billing_amount,
    room_number,
    admission_type,
    discharge_date,
    medication,
    test_results
from base