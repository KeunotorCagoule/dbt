WITH orders AS (
    SELECT 
        order_id,
        user_id,
        order_status,
        order_created_at,
        order_approved_at
    FROM {{ ref('stg_sales_database_order') }} -- Référence obligatoire au staging de la table order 
),

-- Hypothèse : Récupération des informations géographiques depuis le staging des utilisateurs
users AS (
    SELECT 
        user_id,
        user_city,
        user_state
    FROM {{ ref('stg_sales_database_user') }}
),

-- Hypothèse : Agrégation des lignes de l'ordre (order items) pour obtenir les volumes et montants par commande
order_items AS (
    SELECT 
        order_id,
        SUM(price) AS total_order_amount,
        COUNT(item_id) AS total_items,
        COUNT(DISTINCT product_id) AS total_distinct_items
    FROM {{ ref('stg_sales_database_order_items') }}
    GROUP BY 1
),

-- Hypothèse : Calcul de la moyenne des avis reçus par commande
feedbacks AS (
    SELECT 
        order_id,
        AVG(review_score) AS average_feedback_score
    FROM {{ ref('stg_sales_database_feedback') }}
    GROUP BY 1
)

-- Sélection finale combinant toutes les dimensions et métriques demandées 
SELECT
    o.order_id,
    o.user_id,
    o.order_status,
    o.order_created_at,
    o.order_approved_at,
    u.user_city,
    u.user_state,
    f.average_feedback_score,
    oi.total_order_amount,
    oi.total_items, -- Provenant de la table/CTE des items (oi.) [cite: 26]
    oi.total_distinct_items
FROM orders o
LEFT JOIN users u 
    ON o.user_id = u.user_id
LEFT JOIN order_items oi 
    ON o.order_id = oi.order_id
LEFT JOIN feedbacks f 
    ON o.order_id = f.order_id