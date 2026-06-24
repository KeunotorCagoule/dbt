SELECT
    order_id,
    user_id,
    order_created_at
FROM {{ ref('stg_sales_database_order') }}
WHERE order_created_at > CURRENT_DATE()