WITH staffs AS (
    SELECT * FROM {{ ref('stg_sales_staffs') }}
),

joined AS (
    SELECT
        CAST(s.staff_id AS INT64) AS staff_id,
        CONCAT(s.first_name, ' ', s.last_name) AS staff_full_name,
        s.email,
        s.phone,
        s.is_active,
        s.store_id,
        CAST(s.manager_id AS INT64) AS manager_id,
        CONCAT(m.first_name, ' ', m.last_name) AS manager_full_name
    FROM staffs s
    LEFT JOIN staffs m ON CAST(s.manager_id AS INT64) = CAST(m.staff_id AS INT64)
)

SELECT * FROM joined