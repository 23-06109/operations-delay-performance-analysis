# Key Findings

## Executive Summary

This analysis examined 500 operational work orders using PostgreSQL and Power BI to identify overdue workload, backlog aging, team performance, and operational risk.

The analysis shows that backlog risk cannot be evaluated using overdue counts alone. Some teams have high overdue volumes, while others have fewer but significantly older overdue items. Combining volume, overdue rate, and aging provides a more useful management view.

## Core KPIs

- **Total Work Orders:** 500
- **Overdue Open Work Orders:** 106
- **Overall Overdue Rate:** 21.20%
- **Average Days Overdue:** 70.89 days

## Department-Level Findings

### Engineering had the highest overdue rate

Engineering recorded an overdue rate of **23.58%**, the highest among all departments.

Department overdue rates:

- Engineering — 23.58%
- Procurement — 23.29%
- Construction — 21.62%
- Planning — 20.75%
- QA/QC — 16.50%

Construction had the highest number of overdue work orders, but Engineering had the highest overdue rate relative to its total workload.

This demonstrates why normalized performance measures are more informative than raw counts alone.

## Team-Level Findings

### CON-A had the highest combined backlog risk

A custom Backlog Risk Score was created:

**Backlog Risk Score = Overdue Items × Average Days Overdue**

The metric was used as a prioritization tool rather than a standard industry KPI.

CON-A recorded:

- 13 overdue work orders
- 90.54 average days overdue
- Backlog Risk Score: **1,177**

This made CON-A the highest-priority team for backlog intervention.

### QA-B had the oldest average backlog

QA-B had only 2 overdue work orders but recorded the highest average overdue age at:

**126.50 days**

This shows that low backlog volume does not necessarily mean low operational risk.

QA-B represents an aging-risk issue rather than a volume-risk issue.

## Root-Cause Analysis: QA-A

QA-A initially appeared as a high-risk team based on overdue rate.

Further drill-down was performed by:

- Category
- Priority
- Category and priority combination
- Days overdue
- Average aging by category

### Quality Documentation showed the largest backlog-volume issue

Quality Documentation recorded:

- 9 total work orders
- 4 overdue items
- 44.44% overdue rate

It accounted for half of QA-A's overdue backlog.

### Inspection showed stronger aging severity

Inspection recorded:

- 3 overdue items
- 77 average days overdue
- Maximum aging of 117 days

Quality Documentation contributed more overdue items, while Inspection contained older unresolved work.

This suggests that backlog volume and backlog aging should be managed separately.

## Management Recommendations

1. **Prioritize CON-A for immediate backlog reduction**

   CON-A combines high overdue volume with long average aging, making it the strongest overall operational risk.

2. **Investigate QA-B's long-aging work orders**

   Although QA-B has only two overdue items, their average age exceeds 126 days and should be reviewed for unresolved blockers.

3. **Review the QA-A Quality Documentation workflow**

   Quality Documentation contributes the largest share of QA-A's overdue backlog and may indicate workflow, approval, or coordination bottlenecks.

4. **Escalate aging Inspection items**

   Inspection work has fewer overdue records but substantially longer aging and may require targeted escalation.

5. **Use multiple performance measures**

   Management should evaluate:

   - Overdue volume
   - Overdue rate
   - Average days overdue
   - Backlog aging
   - Team-level risk

   rather than relying on a single KPI.

## Analytical Takeaway

The project demonstrates that operational performance cannot be assessed accurately through workload volume alone.

By combining SQL-based backlog analysis with Power BI visualization, the analysis identified different types of operational risk:

- **Volume risk**
- **Rate-based performance risk**
- **Aging risk**
- **Category-level process risk**

This allows management to prioritize interventions based on both scale and severity.
