WITH customers AS (
    SELECT * FROM {{ ref('stg_sales_customers') }}
),

formatted AS (
    SELECT
        customer_id,
        CONCAT(first_name, ' ', last_name) AS customer_full_name,
        phone,
        email,
        street,
        city,
        state,
        zip_code,
        CONCAT(street, ', ', zip_code, ' ', city, ', ', state) AS full_address
    FROM customers
)

SELECT * FROM formatted