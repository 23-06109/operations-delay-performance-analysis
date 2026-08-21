-- Portfolio #2: Operations Delay & Performance Analysis
-- File: 02_overdue_analysis.sql
-- Purpose: Analyze overdue workload by department and aging severity.

-- 1. Total overdue open work orders
SELECT
    COUNT(*) AS overdue_open_work_orders
FROM work_orders
WHERE status <> 'Completed'
  AND duedate < DATE '2026-08-16';


-- 2. Overdue open work orders by department
SELECT
    department,
    COUNT(*) AS overdue_open_work_orders
FROM work_orders
WHERE status <> 'Completed'
  AND duedate < DATE '2026-08-16'
GROUP BY department
ORDER BY overdue_open_work_orders DESC;


-- 3. Overdue rate by department
-- This normalizes overdue workload by department size.
SELECT
    department,
    COUNT(*) AS total_work_orders,

    COUNT(*) FILTER (
        WHERE status <> 'Completed'
          AND duedate < DATE '2026-08-16'
    ) AS overdue_open_work_orders,

    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE status <> 'Completed'
              AND duedate < DATE '2026-08-16'
        ) / COUNT(*),
        2
    ) AS overdue_rate_percent

FROM work_orders
GROUP BY department
ORDER BY overdue_rate_percent DESC;


-- 4. Detailed list of overdue work orders
SELECT
    workorderid,
    department,
    assignedteam,
    category,
    priority,
    duedate,
    DATE '2026-08-16' - duedate AS days_overdue
FROM work_orders
WHERE status <> 'Completed'
  AND duedate < DATE '2026-08-16'
ORDER BY days_overdue DESC;


-- 5. Average aging of overdue work by department
SELECT
    department,
    COUNT(*) AS overdue_items,

    ROUND(
        AVG(DATE '2026-08-16' - duedate),
        2
    ) AS avg_days_overdue,

    MAX(
        DATE '2026-08-16' - duedate
    ) AS max_days_overdue

FROM work_orders
WHERE status <> 'Completed'
  AND duedate < DATE '2026-08-16'
GROUP BY department
ORDER BY avg_days_overdue DESC;
