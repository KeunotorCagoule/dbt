SELECT
    order_id,
    item_id,
    list_price,
    quantity,
    discount,
    (quantity * list_price * (1 - discount)) AS total_amount
FROM {{ ref('stg_sales_order_items') }}
WHERE (quantity * list_price * (1 - discount)) < 0