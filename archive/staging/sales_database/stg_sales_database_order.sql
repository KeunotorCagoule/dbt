WITH source AS (
    -- On appelle la table brute (si c'est un seed, tu peux remplacer par ref('order'))
    SELECT * FROM {{ source('sales_database', 'order') }}
),

renamed AS (
    SELECT
        order_id,
        user_id,
        order_date,
        order_amount
    FROM source
)

SELECT * FROM renamed