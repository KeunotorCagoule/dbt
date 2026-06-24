WITH user_base AS (
    SELECT 
        user_id,
        customer_city -- Nom de la colonne spécifié dans le TD
    FROM {{ ref('stg_sales_database_user') }} -- À ajuster selon le nom exact de ton staging user
),

user_orders_aggregates AS (
    SELECT
        user_id,
        SUM(total_order_amount) AS total_amount_order, -- Somme des montants de toutes les commandes de l'utilisateur
        COUNT(order_id) AS total_order                 -- Nombre total de commandes passées par l'utilisateur
    FROM {{ ref('int_sales_database_order') }}         -- Utilisation du modèle intermédiaire précédent
    GROUP BY 1
)

SELECT
    u.user_id,
    u.customer_city,
    COALESCE(o.total_amount_order, 0) AS total_amount_order,
    COALESCE(o.total_order, 0) AS total_order
FROM user_base u
LEFT JOIN user_orders_aggregates o 
    ON u.user_id = o.user_id