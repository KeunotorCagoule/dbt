WITH source AS (
    SELECT * FROM {{ source('local_bike', 'products') }}
),

renamed AS (
    SELECT
        product_id,
        product_name,
        brand_id,
        category_id,
        model_year,
        CAST(list_price AS NUMERIC) AS list_price
    FROM source
)

SELECT * FROM renamed