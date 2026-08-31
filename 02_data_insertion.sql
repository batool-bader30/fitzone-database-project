-- ==========================================
-- FitZone Gym Management System - Sample Data
-- Phase 3: Insert Initial Records
-- ==========================================

-- Insert Categories
INSERT INTO categories (category_name) 
VALUES ('Yoga'), ('Cardio'), ('Weightlifting'), ('Boxing'), ('Pilates');

-- Insert Trainers
INSERT INTO trainers (full_name, email, phone_number, mentor_id) VALUES
('Omar Khalil',     'omar.k@fitzone.com',    '0771000001', NULL),
('Lina Haddad',     'lina.h@fitzone.com',    '0771000002', NULL),
('Sara Ahmad',      'sara.a@fitzone.com',    '0771000003', 1),
('Fadi Nasser',     'fadi.n@fitzone.com',    '0771000004', 1),
('Yasmin Odeh',     'yasmin.o@fitzone.com',  '0771000005', 2),
('Hussam Rami',     'hussam.r@fitzone.com',  '0771000006', NULL);

-- Insert Classes
INSERT INTO classes (class_name, category_id) VALUES
('Morning Yoga Flow',        1),
('Power Yoga',               1),
('HIIT Cardio Blast',         2),
('Spin Class',                2),
('Cardio Kickbox',            2),
('Strength Basics',           3),
('Olympic Lifting',           3),
('Powerlifting 101',          3),
('Boxing Fundamentals',       4),
('Advanced Boxing Sparring',  4);

-- Insert Sessions
INSERT INTO sessions (session_date, start_time, end_time, room, class_id, trainer_id) VALUES
('2026-08-01', '08:00', '09:00', 'Room A', 1, 1),
('2026-08-03', '08:00', '09:00', 'Room A', 1, 1),
('2026-08-05', '17:00', '18:00', 'Room A', 2, 3),
('2026-08-01', '10:00', '11:00', 'Room B', 3, 2),
('2026-08-02', '10:00', '11:00', 'Room B', 3, 2),
('2026-08-04', '18:00', '19:00', 'Room C', 4, 5),
('2026-08-06', '18:00', '19:00', 'Room C', 4, 5),
('2026-08-02', '09:00', '10:00', 'Room B', 5, 2),
('2026-08-07', '09:00', '10:00', 'Room B', 5, 6),
('2026-08-01', '16:00', '17:00', 'Room D', 6, 4),
('2026-08-03', '16:00', '17:00', 'Room D', 6, 4),
('2026-08-05', '16:00', '17:00', 'Room D', 6, 4),
('2026-08-02', '17:00', '18:30', 'Room D', 7, 1),
('2026-08-06', '17:00', '18:30', 'Room D', 7, 1),
('2026-08-04', '07:00', '08:00', 'Room D', 8, 4),
('2026-08-08', '07:00', '08:00', 'Room D', 8, 6),
('2026-08-01', '19:00', '20:00', 'Room E', 9, 6),
('2026-08-03', '19:00', '20:00', 'Room E', 9, 6),
('2026-08-05', '19:00', '20:00', 'Room E', 10, 6),
('2026-08-07', '19:00', '20:00', 'Room E', 10, 6),
('2026-08-08', '11:00', '12:00', 'Room A', 2, 3),
('2026-08-09', '11:00', '12:00', 'Room B', 5, 2);

-- Insert Members
INSERT INTO members (phone_number, email, full_name, country, city, street, join_date) VALUES
('0791000001', 'khaled@mail.com', 'Khaled Mansour', 'Jordan', 'Amman',  'Rainbow St',      '2025-01-10'),
('0791000002', 'mona@mail.com',   'Mona Saleh',     'Jordan', 'Irbid',  'University St',   '2025-02-15'),
('0791000003', 'karim@mail.com',  'Karim Youssef',  'Jordan', 'Amman',  'Wasfi Al-Tal St', '2025-03-05'),
('0791000004', 'laila@mail.com',  'Laila Nasr',     'Jordan', 'Zarqa',  'King Talal St',   '2025-04-20'),
('0791000005', 'ziad@mail.com',   'Ziad Barakat',   'Jordan', 'Amman',  'Mecca St',        '2025-05-01'),
('0791000006', 'rana@mail.com',   'Rana Fares',     'Jordan', 'Salt',   'Al-Salt St',      '2025-06-11'),
('0791000007', 'tarek@mail.com',  'Tarek Awad',     'Jordan', 'Amman',  'Gardens St',      '2025-07-22'),
('0791000008', 'dana@mail.com',   'Dana Hijazi',    'Jordan', 'Irbid',  'Al-Hussein St',   '2025-08-30'),
('0791000009', 'sami@mail.com',   'Sami Kanaan',    'Jordan', 'Amman',  'Abdoun St',       '2025-10-05'),
('0791000010', 'nour@mail.com',   'Nour Khatib',    'Jordan', 'Aqaba',  'Corniche St',     '2025-11-18');

-- Insert Bookings
INSERT INTO bookings (rating, feedback, member_id, session_id) VALUES
(5, 'Great session!',            1, 1),
(4, 'Really enjoyed it',         1, 3),
(5, 'Loved the energy',          1, 9),
(3, 'Good but too crowded',      2, 4),
(4, NULL,                        2, 6),
(5, 'Best trainer ever',         3, 2),
(NULL, NULL,                     3, 5),
(4, 'Solid workout',             4, 7),
(5, 'Amazing coach',             4, 10),
(2, 'Room was too hot',          5, 8),
(4, NULL,                        5, 11),
(5, 'Perfect pace',              6, 12),
(3, 'Decent',                    6, 13),
(NULL, NULL,                     7, 14),
(4, 'Will come back',            7, 15),
(5, 'Excellent form tips',       8, 16),
(4, 'Fun class',                 8, 17),
(5, 'Challenging in a good way', 9, 18),
(3, 'A bit fast paced',          9, 19),
(4, 'Great trainer',             1, 20),
(5, NULL,                        6, 21);