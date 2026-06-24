SELECT
    order_id,
    order_date
FROM {{ ref('stg_sales_orders') }}
WHERE order_date > CURRENT_DATE()