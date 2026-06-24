WITH source AS (
    SELECT * FROM {{ source('local_bike', 'brands') }}
),

renamed AS (
    SELECT
        brand_id,
        brand_name
    FROM source
)

SELECT * FROM renamed