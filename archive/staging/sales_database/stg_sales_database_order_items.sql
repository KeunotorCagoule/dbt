WITH source AS (
    SELECT * FROM {{ source('sales_database', 'order_items') }}
),

renamed AS (
    SELECT
        order_item_id,
        order_id,
        product_id,
        price
    FROM source
)

SELECT * FROM renamed