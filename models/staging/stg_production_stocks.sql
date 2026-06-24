WITH source AS (
    SELECT * FROM {{ source('local_bike', 'stocks') }}
),

renamed AS (
    SELECT
        store_id,
        product_id,
        quantity
    FROM source
)

SELECT * FROM renamed