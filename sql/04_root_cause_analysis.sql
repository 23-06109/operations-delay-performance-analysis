-- Portfolio #2: Operations Delay & Performance Analysis
-- File: 04_root_cause_analysis.sql
-- Purpose: Drill down into QA-A to identify category, priority,
-- and aging patterns contributing to overdue backlog.


-- 1. Overdue rate by category within QA-A
SELECT
    category,
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
WHERE assignedteam = 'QA-A'
GROUP BY category
ORDER BY overdue_rate_percent DESC;


-- 2. Overdue rate by priority within QA-A
SELECT
    priority,
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
WHERE assignedteam = 'QA-A'
GROUP BY priority
ORDER BY overdue_rate_percent DESC;


-- 3. Category and priority combination analysis
SELECT
    category,
    priority,
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
WHERE assignedteam = 'QA-A'
GROUP BY category, priority
ORDER BY overdue_rate_percent DESC, total_work_orders DESC;


-- 4. Detailed aging of QA-A overdue work orders
SELECT
    workorderid,
    category,
    priority,
    duedate,
    DATE '2026-08-16' - duedate AS days_overdue

FROM work_orders
WHERE assignedteam = 'QA-A'
  AND status <> 'Completed'
  AND duedate < DATE '2026-08-16'

ORDER BY days_overdue DESC;


-- 5. Aging severity by category within QA-A
SELECT
    category,
    COUNT(*) AS overdue_items,

    ROUND(
        AVG(DATE '2026-08-16' - duedate),
        2
    ) AS avg_days_overdue,

    MAX(
        DATE '2026-08-16' - duedate
    ) AS max_days_overdue

FROM work_orders
WHERE assignedteam = 'QA-A'
  AND status <> 'Completed'
  AND duedate < DATE '2026-08-16'

GROUP BY category
ORDER BY avg_days_overdue DESC;
