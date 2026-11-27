-- Portfolio #2: Operations Delay & Performance Analysis
-- File: 00_schema.sql
-- Purpose: Create the work_orders table matching data/Portfolio_02_Work_Orders_500.csv.

CREATE TABLE IF NOT EXISTS work_orders (
    workorderid     VARCHAR(20) PRIMARY KEY,
    department      VARCHAR(50) NOT NULL,
    category        VARCHAR(100) NOT NULL,
    priority        VARCHAR(20) NOT NULL,
    assignedteam    VARCHAR(20) NOT NULL,
    createddate     DATE NOT NULL,
    duedate         DATE NOT NULL,
    completeddate   DATE,
    status          VARCHAR(30) NOT NULL,
    estimatedhours  NUMERIC(10, 2) NOT NULL,
    actualhours     NUMERIC(10, 2),
    cost            NUMERIC(12, 2) NOT NULL
);
