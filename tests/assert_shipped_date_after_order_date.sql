SELECT
    order_id,
    order_date,
    shipped_date
FROM {{ ref('stg_sales_orders') }}
WHERE shipped_date IS NOT NULL
  AND shipped_date < order_date