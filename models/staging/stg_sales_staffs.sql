WITH source AS (
    SELECT * FROM {{ source('local_bike', 'staffs') }}
),

renamed AS (
    SELECT
        CAST(staff_id AS STRING) AS staff_id,
        first_name,
        last_name,
        email,
        phone,
        CAST(active AS BOOLEAN) AS is_active,
        CAST(store_id AS STRING) AS store_id,
        CASE 
            WHEN UPPER(TRIM(CAST(manager_id AS STRING))) IN ('NULL', 'NONE', '') THEN CAST(NULL AS STRING)
            ELSE CAST(manager_id AS STRING)
        END AS manager_id
    FROM source
)

SELECT * FROM renamed