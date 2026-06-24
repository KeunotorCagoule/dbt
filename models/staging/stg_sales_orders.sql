WITH source AS (
    SELECT * FROM {{ source('local_bike', 'orders') }}
),

renamed AS (
    SELECT
        order_id,
        customer_id,
        order_status,
        CAST(order_date AS DATE) AS order_date,
        CAST(required_date AS DATE) AS required_date,
        CAST(shipped_date AS DATE) AS shipped_date,
        store_id,
        staff_id
    FROM source
)

SELECT * FROM renamed