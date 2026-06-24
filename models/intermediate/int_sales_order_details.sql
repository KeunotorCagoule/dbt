WITH orders AS (
    SELECT * FROM {{ ref('stg_sales_orders') }}
),

order_items AS (
    SELECT * FROM {{ ref('stg_sales_order_items') }}
),

joined AS (
    SELECT
        CONCAT(CAST(o.order_id AS STRING), '-', CAST(oi.item_id AS STRING)) AS order_item_id,
        o.order_id,
        o.order_date,
        o.order_status,
        o.required_date,
        o.shipped_date,
        o.store_id,
        o.staff_id,
        o.customer_id,
        oi.item_id,
        oi.product_id,
        oi.quantity,
        oi.list_price,
        oi.discount,
        (oi.quantity * oi.list_price * (1 - oi.discount)) AS item_revenue
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
)

SELECT * FROM joined