WITH source AS (
    SELECT * FROM {{ source('local_bike', 'order_items') }}
),

renamed AS (
    SELECT
        order_id,
        item_id,
        product_id,
        quantity,
        list_price,
        discount
    FROM source
)

SELECT * FROM renamed