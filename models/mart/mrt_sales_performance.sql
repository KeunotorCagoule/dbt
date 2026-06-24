WITH sales AS (
    SELECT * FROM {{ ref('int_sales_order_details') }}
),
catalog AS (
    SELECT * FROM {{ ref('int_product_catalog') }}
),
stores AS (
    SELECT * FROM {{ ref('stg_sales_stores') }}
),
customers AS (
    SELECT * FROM {{ ref('int_customer_profiles') }}
),

final_mart AS (
    SELECT
        s.order_id,
        CAST(s.order_date AS DATE) AS order_date,
        s.order_status,
        s.quantity,
        s.item_revenue,
        st.store_name,
        c.product_name,
        c.category_name,
        c.brand_name,
        cust.customer_full_name,
        cust.city AS customer_city,
        cust.state AS customer_state
    FROM sales s
    JOIN catalog c ON s.product_id = c.product_id
    JOIN stores st ON s.store_id = st.store_id
    JOIN customers cust ON s.customer_id = cust.customer_id
)

SELECT * FROM final_mart