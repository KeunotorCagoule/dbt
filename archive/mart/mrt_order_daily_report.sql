WITH orders AS (
    SELECT * FROM {{ ref('int_sales_database_order') }}
),

account_managers AS (
    SELECT * FROM {{ ref('stg_google_sheets_account_manager_region_mapping') }}
)

SELECT
    -- Dimensions
    DATE(o.order_created_at) AS order_date,
    am.account_manager,
    o.user_state, 
    
    -- Métriques
    COUNT(o.order_id) AS total_orders,
    AVG(o.total_items) AS avg_items_per_order,
    AVG(o.average_feedback_score) AS avg_feedback_score,
    AVG(o.total_order_amount) AS avg_order_amount

FROM orders o
LEFT JOIN account_managers am
    ON o.user_state = am.state_column_name -- À modifier avec le vrai nom de ta colonne si besoin
GROUP BY 
    1, 2, 3