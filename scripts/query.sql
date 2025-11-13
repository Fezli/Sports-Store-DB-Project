-- Использование представления (отчет по покупкам) для получения отчета по категории Бег за февраль
SELECT
    purchase_date,
    product_name,
    quantity,
    price_per_item,
    line_total,
    client_fio,
    employee_fio
FROM
    v_detailed_sales_report
WHERE
    category_name = 'Бег'
    AND purchase_date BETWEEN '2025-02-01' AND '2025-02-28'
ORDER BY
    purchase_date;

-- Использование представления для поиска вип-клинтов (больше 3 покупок и ср. чек болше 10.000)
SELECT
    client_fio,
    order_count,
    total_spent,
    avg_check,
    last_purchase_date
FROM
    v_customer_analytics
WHERE
    order_count > 3
    AND avg_check > 10000.00
ORDER BY
    total_spent DESC;

-- Таблица помесячного роста выручки
WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('month', data)::date AS sales_month,
        SUM(summ) AS monthly_revenue
    FROM transaction
    WHERE summ > 0
    GROUP BY sales_month
)
SELECT
    sales_month,
    monthly_revenue,
    LAG(monthly_revenue, 1, 0) OVER (ORDER BY sales_month) AS previous_month_revenue,
    CASE
        WHEN LAG(monthly_revenue, 1, 0) OVER (ORDER BY sales_month) > 0
        THEN (monthly_revenue - LAG(monthly_revenue, 1, 0) OVER (ORDER BY sales_month)) * 100.0 / LAG(monthly_revenue, 1, 0) OVER (ORDER BY sales_month)
        ELSE NULL
    END AS mom_growth_percentage
FROM monthly_sales
ORDER BY sales_month;


-- Поиск сопутствующих товаров (тоесть товары, которое чаще всего покупают вместе самым продоваемым товаром)
WITH bestseller AS (
    SELECT
        product_id
    FROM purchase_product
    GROUP BY product_id
    ORDER BY SUM(quantity) DESC
    LIMIT 1
),
bestseller_purchases AS (
    SELECT
        purchase_id
    FROM purchase_product
    WHERE product_id = (SELECT product_id FROM bestseller)
)
SELECT
    p.name AS associated_product,
    COUNT(*) AS frequency
FROM purchase_product pp
JOIN product p ON pp.product_id = p.product_id
WHERE
    pp.purchase_id IN (SELECT purchase_id FROM bestseller_purchases)
    AND pp.product_id != (SELECT product_id FROM bestseller)
GROUP BY
    p.name
ORDER BY
    frequency DESC
LIMIT 5;