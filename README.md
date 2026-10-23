# Operations Delay & Performance Analysis

When a tracker only counts late items, it is hard to tell a heavy workload from a high share of late work, or from a few items that have been open for a long time. This sample compares those three views on one set of work orders, and they point to different teams. The outcome is a review order for this snapshot, with no measured change in the backlog afterward.

## What you'd get

This repository includes:

- The source tracker [Portfolio_02_Work_Orders_500.csv](data/Portfolio_02_Work_Orders_500.csv): 500 work orders with department, category, priority, assigned team, dates, status, estimated hours, actual hours, and cost.
- Five SQL scripts that count workload, compare overdue rate and aging by department and team, calculate a project-specific backlog risk score, and drill into team QA-A by category and priority.
- The SQL view `vw_work_order_analysis`, which adds open or completed state, overdue status, days overdue, completion timing, and hours variance.
- The findings note [key-findings.md](insights/key-findings.md), with the snapshot figures and the review order those figures suggest.
- The dashboard screenshot below. The editable Power BI file is not in this repo.

All data in this repo is synthetic demo/sample data, not client work.

![Operations delay dashboard comparing department overdue rates, team aging and backlog risk](dashboard/operations-delay-dashboard.png)

## Business Problem

Managers need to see where work is stuck across departments and teams. A raw overdue count can hide whether a team has a large workload, a high proportion of late work, or a small number of very old cases.

## Solution

**Data → SQL Analysis → KPI Visibility → Insight → Management Decision**

PostgreSQL queries explore the data, compare overdue workload and team performance, and drill into category and priority patterns. A reusable analytical view prepares the fields shown in the Power BI dashboard screenshot.

## Data

The repository contains **500 simulated work orders** across Engineering, QA/QC, Construction, Procurement, and Planning. Fields include dates, status, assigned team, priority, estimated hours, actual hours, and cost.

All overdue calculations use the fixed cutoff **16 August 2026**, matching the SQL and the saved dashboard. The overdue rate uses all work orders as the denominator. Average overdue age uses overdue open work orders only.

## Analysis

| Script | Analytical purpose |
|---|---|
| [01. Data exploration](sql/01_data_exploration.sql) | Inspect row counts and workload by status and department. |
| [02. Overdue analysis](sql/02_overdue_analysis.sql) | Compare department overdue counts, rates, and aging. |
| [03. Team analysis](sql/03_team_analysis.sql) | Compare team backlog volume, overdue age, and combined risk. |
| [04. Category and priority investigation](sql/04_root_cause_analysis.sql) | Drill into QA-A's backlog and identify areas to investigate. |
| [05. Analytical view](sql/05_analysis_view.sql) | Create `vw_work_order_analysis` for Power BI. |

**Backlog Risk Score = Overdue Items × Average Days Overdue.** This is a project-specific prioritization measure, not a standard industry KPI. Category and aging patterns identify investigation targets. They do not prove causal explanations.

## Decision Support

- Prioritize **CON-A** for backlog review: 13 overdue items with 90.54 average overdue days and a backlog risk score of 1,177.
- Review **QA-B's** two overdue items despite the small volume: their average overdue age is 126.50 days.
- Investigate **QA-A Quality Documentation**, with 4 of 9 work orders overdue (44.44%). Review aging in Inspection separately: 3 overdue items, 77 average overdue days, and a maximum of 117 days.
- Compare department rates as well as volumes: Engineering has the highest overdue rate at 23.58%, while Construction has more overdue work orders.

## Automated Action

The reusable SQL view calculates operational reporting fields for downstream analysis. This project supports management prioritization. It does not implement scheduled reporting, notifications, or work-order updates.

## Measured / Demonstrated Outcome

| Measure | Result at 16 August 2026 |
|---|---:|
| Total work orders | 500 |
| Overdue open work orders | 106 |
| Overdue rate, all work orders | 21.20% |
| Average overdue age, overdue open only | 70.89 days |

The saved dashboard and [findings](insights/key-findings.md) show how different risk measures lead to different management priorities. These are simulated-data findings. Backlog reduction after intervention has not been measured.

## Tools and Outputs

PostgreSQL, SQL, and a Power BI dashboard screenshot. The repository includes the source CSV, the SQL scripts, the findings note, and the screenshot. **The editable Power BI file is not included.**

## How to Run

1. Create a local PostgreSQL database and a `work_orders` table matching the CSV header, using lowercase unquoted column names. Use text for identifiers, categories, and status, `DATE` for the three date columns, and numeric types for hours and cost. No database creation script or table DDL file is included.
2. Import [Portfolio_02_Work_Orders_500.csv](data/Portfolio_02_Work_Orders_500.csv) with the header row enabled and blank completion dates treated as null. pgAdmin can do that import.
3. Run scripts 01 to 04, then script 05 to create `vw_work_order_analysis`. Keep the supplied cutoff to reproduce the reported snapshot.
4. To rebuild the visual report, connect Power BI Desktop to that view and use the saved screenshot as a layout reference. To review the existing analysis, Power BI is not required.

The steps above describe the setup. They are not a one-command installation.

[Portfolio overview](https://github.com/23-06109#selected-projects)

## Work with me

I offer a fixed-price, async Operations Reporting Automation Sprint: you send a messy Excel/CSV tracker, I send back a clean report that rebuilds on refresh, an overdue action list and a short how-to video. No meetings. Message me on LinkedIn: https://www.linkedin.com/in/jimmyjrmanalon/
