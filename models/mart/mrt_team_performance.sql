WITH sales AS (
    SELECT * FROM {{ ref('int_sales_order_details') }}
),
staff AS (
    SELECT * FROM {{ ref('int_staff_hierarchy') }}
),

final_mart AS (
    SELECT
        s.order_id,
        CAST(s.order_date AS DATE) AS order_date,
        s.item_revenue,
        st.staff_full_name,
        st.manager_full_name,
        st.is_active
    FROM sales s
    JOIN staff st ON s.staff_id = st.staff_id
)

SELECT * FROM final_mart