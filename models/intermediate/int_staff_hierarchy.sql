WITH staffs AS (
    SELECT * FROM {{ ref('stg_sales_staffs') }}
),

joined AS (
    SELECT
        s.staff_id,
        CONCAT(s.first_name, ' ', s.last_name) AS staff_full_name,
        s.email,
        s.phone,
        s.is_active,
        s.store_id,
        s.manager_id,
        CONCAT(m.first_name, ' ', m.last_name) AS manager_full_name
    FROM staffs s
    LEFT JOIN staffs m ON s.manager_id = m.staff_id
)

SELECT * FROM joined