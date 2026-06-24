WITH products AS (
    SELECT * FROM {{ ref('stg_production_products') }}
),

categories AS (
    SELECT * FROM {{ ref('stg_production_categories') }}
),

brands AS (
    SELECT * FROM {{ ref('stg_production_brands') }}
),

joined AS (
    SELECT
        p.product_id,
        p.product_name,
        p.model_year,
        p.list_price AS product_base_price,
        c.category_name,
        b.brand_name
    FROM products p
    JOIN categories c ON p.category_id = c.category_id
    JOIN brands b ON p.brand_id = b.brand_id
)

SELECT * FROM joined