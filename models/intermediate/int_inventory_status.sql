WITH stocks AS (
    SELECT * FROM {{ ref('stg_production_stocks') }}
),

catalog AS (
    SELECT * FROM {{ ref('int_product_catalog') }}
),

joined AS (
    SELECT
        s.store_id,
        s.product_id,
        c.product_name,
        c.brand_name,
        c.category_name,
        s.quantity AS current_stock
    FROM stocks s
    JOIN catalog c ON s.product_id = c.product_id
)

SELECT * FROM joined