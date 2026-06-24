WITH source AS (
    SELECT * FROM {{ source('local_bike', 'categories') }}
),

renamed AS (
    SELECT
        category_id,
        category_name
    FROM source
)

SELECT * FROM renamed