WITH source AS (
    SELECT * FROM {{ source('local_bike', 'orders') }}
),

renamed AS (
    SELECT
        order_id,
        customer_id,
        order_status,
        CASE 
            WHEN UPPER(TRIM(CAST(order_date AS STRING))) IN ('NULL', 'NONE', '') THEN CAST(NULL AS DATE)
            ELSE CAST(order_date AS DATE)
        END AS order_date,
        CASE 
            WHEN UPPER(TRIM(CAST(required_date AS STRING))) IN ('NULL', 'NONE', '') THEN CAST(NULL AS DATE)
            ELSE CAST(required_date AS DATE)
        END AS required_date,
        CASE 
            WHEN UPPER(TRIM(CAST(shipped_date AS STRING))) IN ('NULL', 'NONE', '') THEN CAST(NULL AS DATE)
            ELSE CAST(shipped_date AS DATE)
        END AS shipped_date,
        store_id,
        staff_id
    FROM source
)

SELECT * FROM renamed