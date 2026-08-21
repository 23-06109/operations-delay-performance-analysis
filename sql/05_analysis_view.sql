-- Portfolio #2: Operations Delay & Performance Analysis
-- File: 05_analysis_view.sql
-- Purpose: Create a reusable analytical view for Power BI.

CREATE OR REPLACE VIEW vw_work_order_analysis AS
SELECT
    workorderid,
    department,
    category,
    priority,
    assignedteam,
    createddate,
    duedate,
    completeddate,
    status,
    estimatedhours,
    actualhours,
    cost,

    -- Completed vs Open
    CASE
        WHEN status = 'Completed' THEN 'Completed'
        ELSE 'Open'
    END AS work_order_state,

    -- Identify currently overdue open work orders
    CASE
        WHEN status <> 'Completed'
         AND duedate < DATE '2026-08-16'
        THEN 'Overdue'
        ELSE 'Not Overdue'
    END AS overdue_status,

    -- Days overdue for open overdue work
    CASE
        WHEN status <> 'Completed'
         AND duedate < DATE '2026-08-16'
        THEN DATE '2026-08-16' - duedate
        ELSE 0
    END AS days_overdue,

    -- Completed work performance
    CASE
        WHEN status = 'Completed'
         AND completeddate > duedate
        THEN 'Late'

        WHEN status = 'Completed'
        THEN 'On Time'

        ELSE 'Open'
    END AS completion_performance,

    -- Days late for completed work
    CASE
        WHEN status = 'Completed'
         AND completeddate > duedate
        THEN completeddate - duedate
        ELSE 0
    END AS completion_delay_days,

    -- Difference between actual and estimated effort
    actualhours - estimatedhours AS hours_variance

FROM work_orders;
