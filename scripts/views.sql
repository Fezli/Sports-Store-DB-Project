CREATE OR REPLACE VIEW v_detailed_sales_report AS
SELECT
    p.purchase_id,
    p.date_time AS purchase_date,
    p.type AS purchase_type,

    c.client_id,
    c.fio AS client_fio,

    e.employee_id,
    e.fio AS employee_fio,

    pr.product_id,
    pr.name AS product_name,
    pc.name AS category_name,

    pp.quantity,
    pp.price_per_item,
    (pp.quantity * pp.price_per_item) AS line_total,

    t.summ AS total_purchase_sum

FROM purchase p
JOIN client c ON p.client_id = c.client_id
JOIN purchase_product pp ON p.purchase_id = pp.purchase_id
JOIN product pr ON pp.product_id = pr.product_id
JOIN transaction t ON p.purchase_id = t.purchase_id
LEFT JOIN product_category_prod pcp ON pr.product_id = pcp.product_id
LEFT JOIN product_category pc ON pcp.product_category_id = pc.product_category_id
LEFT JOIN purchase_employee pe ON p.purchase_id = pe.purchase_id
LEFT JOIN employee e ON pe.employee_id = e.employee_id;

COMMENT ON VIEW v_detailed_sales_report IS 'Отчет по по каждой товарной позиции в каждом чеке';


CREATE OR REPLACE VIEW v_customer_analytics AS
SELECT
    c.client_id,
    c.fio AS client_fio,
    c.email,

    COALESCE(SUM(t.summ), 0) AS total_spent,
    COALESCE(COUNT(DISTINCT p.purchase_id), 0) AS order_count,

    CASE
        WHEN COUNT(DISTINCT p.purchase_id) > 0 THEN AVG(t.summ)
        ELSE 0
    END AS avg_check,

    MIN(p.date_time) AS first_purchase_date,
    MAX(p.date_time) AS last_purchase_date

FROM client c
LEFT JOIN purchase p ON c.client_id = p.client_id
LEFT JOIN transaction t ON p.purchase_id = t.purchase_id
GROUP BY
    c.client_id,
    c.fio,
    c.email;

COMMENT ON VIEW v_customer_analytics IS 'Отчет по каждому клиенту';