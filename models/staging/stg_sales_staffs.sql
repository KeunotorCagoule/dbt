WITH source AS (
    SELECT * FROM {{ source('local_bike', 'staffs') }}
),

renamed AS (
    SELECT
        staff_id,
        first_name,
        last_name,
        email,
        phone,
        CAST(active AS BOOLEAN) AS is_active,
        store_id,
        manager_id
    FROM source
)

SELECT * FROM renamed