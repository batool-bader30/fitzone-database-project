# 🏋️‍♂️ FitZone Gym Management System (PostgreSQL Database)

A comprehensive, robust PostgreSQL database solution designed to manage gym operations, including members, trainers, classes, session scheduling, bookings, feedback, and audit logging.

This project demonstrates core concepts of relational database design, data integrity, advanced SQL queries, security administration (DCL), and programmable database logic (PL/pgSQL).

---

## 📌 Project Overview

**FitZone** is a full-featured database backend that streamlines day-to-day gym activities. Key functional domains include:

- **Member Management:** Track member profiles, join dates, activity status, and loyalty reward points.
- **Trainer & Hierarchy Tracking:** Manage trainer profiles and self-referencing mentoring relationships.
- **Class & Session Scheduling:** Structure workout categories, scheduled sessions, and room assignments.
- **Booking & Rating Engine:** Allow members to book sessions, provide ratings (1-5), and leave feedback.
- **Audit & Security:** Maintain security via role-based privileges and audit execution history via triggers.

---

## 📂 Project Structureس

The project is structured into **5 modular SQL files** for easy setup and execution:

```text
fitzone-database-project/
├── 01_schema_design.sql           # Schema definition, Constraints & DCL User Roles
├── 02_data_insertion.sql          # Initial sample data seed (Categories, Trainers, Members, etc.)
├── 03_queries_and_reports.sql     # Analytical queries, Joins, Aggregations & Subqueries
├── 04_plpgsql_programmables.sql   # Stored Functions, Procedures & Exception Handling
└── 05_triggers_and_auditing.sql   # Data Integrity Triggers & Audit Logging Engine
```
"# fitzone-database-project" 
