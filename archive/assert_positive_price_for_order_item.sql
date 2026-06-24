SELECT
    order_item_id,
    order_id,
    price
FROM {{ ref('stg_sales_database_order_items') }}
WHERE price < 0