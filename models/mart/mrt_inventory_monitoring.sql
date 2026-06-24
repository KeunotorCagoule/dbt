WITH inventory AS (
    SELECT * FROM {{ ref('int_inventory_status') }}
),
stores AS (
    SELECT * FROM {{ ref('stg_sales_stores') }}
),

final_mart AS (
    SELECT
        st.store_name,
        i.product_name,
        i.brand_name,
        i.category_name,
        i.current_stock,
        CASE 
            WHEN i.current_stock = 0 THEN 'Rupture'
            WHEN i.current_stock < 5 THEN 'Alerte'
            ELSE 'En stock'
        END AS stock_alert_status
    FROM inventory i
    JOIN stores st ON i.store_id = st.store_id
)

SELECT * FROM final_mart