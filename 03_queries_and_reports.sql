-- ==========================================
-- FitZone Gym Management System - Queries & Reports
-- Phase 5 & 7: SQL Queries, Joins, Aggregations & Subqueries
-- ==========================================

-- Members ordered by join date
SELECT full_name AS "full name", email FROM members ORDER BY join_date ASC;

-- Distinct cities
SELECT DISTINCT city FROM members;

-- Active members only
SELECT * FROM members WHERE status = 'active';

-- Sessions with class and trainer details
SELECT s.session_id, s.session_date, s.start_time, s.end_time, s.room, c.class_name, t.full_name AS trainer_name
FROM sessions AS s 
JOIN classes AS c ON s.class_id = c.class_id
JOIN trainers AS t ON s.trainer_id = t.trainer_id;

-- Members booking count (including 0 bookings)
SELECT m.full_name, m.email, m.phone_number, COUNT(b.booking_id) AS "booking count"
FROM members AS m
LEFT JOIN bookings AS b ON m.member_id = b.member_id
GROUP BY m.member_id, m.full_name, m.email, m.phone_number;

-- Sessions booking count
SELECT s.session_id, s.session_date, s.room, s.start_time, s.end_time, COUNT(b.booking_id) AS "booking count"
FROM sessions AS s
LEFT JOIN bookings AS b ON s.session_id = b.session_id
GROUP BY s.session_id, s.session_date, s.room, s.start_time, s.end_time;

-- Categories with class details
SELECT c.category_name, cl.class_id, cl.class_name
FROM categories AS c 
LEFT JOIN classes AS cl ON c.category_id = cl.category_id;

-- Trainers and their mentors (Self Join)
SELECT t.full_name AS "trainer", m.full_name AS "Mentor"
FROM trainers AS t 
LEFT JOIN trainers AS m ON t.mentor_id = m.trainer_id;

-- Average rating per trainer
SELECT t.full_name, AVG(b.rating) AS "avg_rating"
FROM trainers AS t 
LEFT JOIN sessions AS s ON t.trainer_id = s.trainer_id
LEFT JOIN bookings AS b ON s.session_id = b.session_id
GROUP BY t.trainer_id, t.full_name;

-- Min and Max rating per class
SELECT c.class_name, MIN(b.rating) AS min_rating, MAX(b.rating) AS max_rating
FROM classes AS c 
LEFT JOIN sessions AS s ON c.class_id = s.class_id
LEFT JOIN bookings AS b ON s.session_id = b.session_id
GROUP BY c.class_id, c.class_name;

-- Total loyalty points by city
SELECT m.city, SUM(m.loyalty_points) AS total_points
FROM members AS m
GROUP BY m.city;

-- Categories with more than 2 classes (HAVING)
SELECT c.category_name, COUNT(cl.class_id) AS "class count"
FROM categories AS c
LEFT JOIN classes AS cl ON c.category_id = cl.category_id
GROUP BY c.category_id, c.category_name
HAVING COUNT(cl.class_id) > 2;

-- Members with no bookings (Subquery)
SELECT member_id, full_name, email
FROM members
WHERE member_id NOT IN (
    SELECT member_id FROM bookings WHERE member_id IS NOT NULL
);

-- Trainers with rating above overall average
SELECT t.trainer_id, t.full_name, AVG(b.rating) AS "trainer avg rating"
FROM trainers AS t
LEFT JOIN sessions AS s ON t.trainer_id = s.trainer_id
LEFT JOIN bookings AS b ON s.session_id = b.session_id
GROUP BY t.trainer_id, t.full_name
HAVING AVG(b.rating) > (
    SELECT AVG(rating) FROM bookings WHERE rating IS NOT NULL
);