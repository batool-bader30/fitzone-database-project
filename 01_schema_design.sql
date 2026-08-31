-- ==========================================
-- FitZone Gym Management System - Database Schema
-- Phase 2 & 6: DDL & Security Administration
-- ==========================================

-- 1. Members Table
CREATE TABLE members (
    member_id       INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    phone_number    VARCHAR(20) UNIQUE,
    email           VARCHAR(30) NOT NULL UNIQUE,
    full_name       VARCHAR(30) NOT NULL,
    country         VARCHAR(20),
    city            VARCHAR(20),
    street          VARCHAR(30),
    join_date       TIMESTAMPTZ NOT NULL DEFAULT CURRENT_DATE,
    status          VARCHAR(10) NOT NULL DEFAULT 'active'
                    CHECK (status IN ('active', 'inactive')),
    loyalty_points  INT DEFAULT 0
);

-- 2. Trainers Table (Self-referencing relationship)
CREATE TABLE trainers (
    trainer_id       INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    full_name        VARCHAR(30) NOT NULL UNIQUE,
    email            VARCHAR(30) NOT NULL UNIQUE,
    phone_number     VARCHAR(20),
    years_experience INT,
    mentor_id        INT REFERENCES trainers(trainer_id) ON DELETE SET NULL
);

-- 3. Categories Table
CREATE TABLE categories (
    category_id   INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    category_name VARCHAR(20) NOT NULL UNIQUE
);

-- 4. Classes Table
CREATE TABLE classes (
    class_id      INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    class_name    VARCHAR(30) NOT NULL,
    category_id   INT NOT NULL REFERENCES categories(category_id) ON DELETE CASCADE
);

-- 5. Sessions Table
CREATE TABLE sessions (
    session_id    INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    session_date  DATE NOT NULL,
    start_time    TIME NOT NULL,
    end_time      TIME NOT NULL,
    room          VARCHAR(20) NOT NULL,
    class_id      INT NOT NULL REFERENCES classes(class_id) ON DELETE CASCADE,
    trainer_id    INT NOT NULL REFERENCES trainers(trainer_id) ON DELETE CASCADE,
    CHECK (end_time > start_time)
);

-- 6. Bookings Table
CREATE TABLE bookings (
    booking_id    INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    rating        INT CHECK (rating BETWEEN 1 AND 5),
    feedback      VARCHAR(255),
    booking_at    TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    member_id     INT NOT NULL REFERENCES members(member_id) ON DELETE CASCADE,
    session_id    INT NOT NULL REFERENCES sessions(session_id) ON DELETE CASCADE
);

-- ==========================================
-- Security & Administration (DCL)
-- ==========================================

-- Create Read-Only User
CREATE USER readonly_user WITH PASSWORD 'R3adOnly!2026#Secure';
GRANT CONNECT ON DATABASE fitzone_db TO readonly_user;
GRANT USAGE ON SCHEMA public TO readonly_user;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO readonly_user;

-- Create Operations Manager User
CREATE USER manager_user WITH PASSWORD 'Mgr#2026$Ops!Secure';
GRANT CONNECT ON DATABASE fitzone_db TO manager_user;
GRANT USAGE ON SCHEMA public TO manager_user;
GRANT SELECT, INSERT, UPDATE ON ALL TABLES IN SCHEMA public TO manager_user;

-- Revoke Update Permission from Manager
REVOKE UPDATE ON ALL TABLES IN SCHEMA public FROM manager_user;