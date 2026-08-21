-- Portfolio #2: Operations Delay & Performance Analysis
-- Data Exploration

-- Preview sample records
SELECT *
FROM work_orders
LIMIT 10;

-- Total work orders
SELECT COUNT(*) AS total_work_orders
FROM work_orders;

-- Work orders by status
SELECT
    status,
    COUNT(*) AS total_work_orders
FROM work_orders
GROUP BY status
ORDER BY total_work_orders DESC;

-- Work orders by department
SELECT
    department,
    COUNT(*) AS total_work_orders
FROM work_orders
GROUP BY department
ORDER BY total_work_orders DESC;

-- Open work orders by department
SELECT
    department,
    COUNT(*) AS open_work_orders
FROM work_orders
WHERE status <> 'Completed'
GROUP BY department
ORDER BY open_work_orders DESC;
