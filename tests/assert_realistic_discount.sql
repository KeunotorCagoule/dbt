SELECT
    order_id,
    item_id,
    list_price,
    discount
FROM {{ ref('stg_sales_order_items') }}
WHERE discount < 0 OR discount >= 1