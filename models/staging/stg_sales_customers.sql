WITH source AS (
    SELECT * FROM {{ source('local_bike', 'customers') }}
),

renamed AS (
    SELECT
        customer_id,
        first_name,
        last_name,
        phone,
        email,
        street,
        city,
        state,
        zip_code
    FROM source
)

SELECT * FROM renamed