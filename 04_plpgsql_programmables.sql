-- ==========================================
-- FitZone Gym Management System - Programmable Logic
-- Functions, Procedures, Controls & Error Handling
-- ==========================================

-- 1. Function: Get member full name by ID
CREATE OR REPLACE FUNCTION get_member_full_name(p_member_id INT)
RETURNS TEXT AS $$
BEGIN
    RETURN (SELECT full_name FROM members WHERE member_id = p_member_id);
END;
$$ LANGUAGE plpgsql;

-- 2. Function: Get average rating by trainer ID
CREATE OR REPLACE FUNCTION get_average_rating_by_trainer(p_trainer_id INT)
RETURNS NUMERIC(10,2) AS $$
BEGIN
    RETURN (
        SELECT AVG(b.rating)
        FROM sessions AS s
        LEFT JOIN bookings AS b ON s.session_id = b.session_id
        WHERE s.trainer_id = p_trainer_id
    );
END;
$$ LANGUAGE plpgsql;

-- 3. Function: Calculate loyalty points
CREATE OR REPLACE FUNCTION calculate_loyalty_points(p_member_id INT)
RETURNS INT AS $$
BEGIN
    RETURN (
        SELECT COUNT(*)
        FROM bookings
        WHERE member_id = p_member_id AND rating = 5
    );
END;
$$ LANGUAGE plpgsql;

-- 4. Function: Check available seats in session
CREATE OR REPLACE FUNCTION available_seats (p_sessions_id INT)
RETURNS INT AS $$
DECLARE v_count INT;
BEGIN
    SELECT COUNT(*) INTO v_count FROM bookings WHERE session_id = p_sessions_id;
    IF v_count > 15 THEN 
        RETURN 0;
    ELSE 
        RETURN 15 - v_count;
    END IF;
END;
$$ LANGUAGE plpgsql;

-- 5. Function: Fetch member by email
CREATE OR REPLACE FUNCTION get_member_by_email(p_email members.email%TYPE)
RETURNS RECORD AS $$
DECLARE rec RECORD;
BEGIN
    SELECT phone_number, email, full_name, country, city, street, status, join_date
    INTO rec
    FROM members
    WHERE email = p_email;
    
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Member not found.';
    END IF;
    RETURN rec;
END;
$$ LANGUAGE plpgsql;

-- 6. Procedure: Add new booking with exception handling
CREATE OR REPLACE PROCEDURE add_new_booking2(p_member_id INT, p_session_id INT)
LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO bookings (member_id, session_id) 
    VALUES(p_member_id, p_session_id);
    RAISE NOTICE 'Member % booked session %', p_member_id, p_session_id;
EXCEPTION
    WHEN unique_violation THEN
        RAISE NOTICE 'Member % is already booked in session %.', p_member_id, p_session_id;
    WHEN foreign_key_violation THEN
        RAISE NOTICE 'Member or session does not exist.';
    WHEN OTHERS THEN
        RAISE NOTICE 'Unexpected error: %', SQLERRM;
END;
$$;

-- 7. Procedure: Update member status
CREATE OR REPLACE PROCEDURE update_member_status(p_member_id INT, p_new_status VARCHAR)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE members SET status = p_new_status WHERE member_id = p_member_id;
    RAISE NOTICE 'Status updated successfully to % for member %', p_new_status, p_member_id;
END;
$$;

-- 8. Procedure: Apply loyalty bonus to members
CREATE OR REPLACE PROCEDURE apply_loyalty_bonus()
LANGUAGE plpgsql AS $$
DECLARE 
    v_member RECORD;
    v_bookingcount INT;
    v_loyalty INT;
BEGIN
    FOR v_member IN SELECT * FROM members LOOP
        SELECT COUNT(*) INTO v_bookingcount FROM bookings WHERE member_id = v_member.member_id;
        SELECT loyalty_points INTO v_loyalty FROM members WHERE member_id = v_member.member_id;

        IF v_bookingcount > 3 AND v_loyalty < 5 THEN
            UPDATE members SET loyalty_points = v_loyalty + 1 WHERE member_id = v_member.member_id;
        END IF;
    END LOOP;
END;
$$;