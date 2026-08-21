-- Portfolio #2: Operations Delay & Performance Analysis
-- File: 03_team_analysis.sql
-- Purpose: Compare team backlog, overdue rates, aging, and operational risk.


-- 1. Overdue rate by team
SELECT
    assignedteam,
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
GROUP BY assignedteam, department
ORDER BY overdue_rate_percent DESC;


-- 2. Average aging of overdue backlog by team
SELECT
    assignedteam,
    department,

    COUNT(*) FILTER (
        WHERE status <> 'Completed'
          AND duedate < DATE '2026-08-16'
    ) AS overdue_items,

    ROUND(
        AVG(
            CASE
                WHEN status <> 'Completed'
                 AND duedate < DATE '2026-08-16'
                THEN DATE '2026-08-16' - duedate
            END
        ),
        2
    ) AS avg_days_overdue

FROM work_orders
GROUP BY assignedteam, department

HAVING COUNT(*) FILTER (
    WHERE status <> 'Completed'
      AND duedate < DATE '2026-08-16'
) > 0

ORDER BY avg_days_overdue DESC;


-- 3. Custom Backlog Risk Score
-- Risk Score = Number of Overdue Items × Average Days Overdue
-- This is a project-specific prioritization metric, not a standard industry KPI.

SELECT
    assignedteam,
    department,

    COUNT(*) FILTER (
        WHERE status <> 'Completed'
          AND duedate < DATE '2026-08-16'
    ) AS overdue_items,

    ROUND(
        AVG(
            CASE
                WHEN status <> 'Completed'
                 AND duedate < DATE '2026-08-16'
                THEN DATE '2026-08-16' - duedate
            END
        ),
        2
    ) AS avg_days_overdue,

    ROUND(
        COUNT(*) FILTER (
            WHERE status <> 'Completed'
              AND duedate < DATE '2026-08-16'
        )
        *
        AVG(
            CASE
                WHEN status <> 'Completed'
                 AND duedate < DATE '2026-08-16'
                THEN DATE '2026-08-16' - duedate
            END
        ),
        2
    ) AS backlog_risk_score

FROM work_orders
GROUP BY assignedteam, department

HAVING COUNT(*) FILTER (
    WHERE status <> 'Completed'
      AND duedate < DATE '2026-08-16'
) > 0

ORDER BY backlog_risk_score DESC;
