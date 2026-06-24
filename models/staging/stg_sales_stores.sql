WITH source AS (
    SELECT * FROM {{ source('local_bike', 'stores') }}
),

renamed AS (
    SELECT
        store_id,
        store_name,
        phone,
        email,
        street,
        city,
        state,
        zip_code
    FROM source
)

SELECT * FROM renamed