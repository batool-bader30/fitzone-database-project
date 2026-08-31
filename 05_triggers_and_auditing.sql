-- ==========================================
-- FitZone Gym Management System - Triggers & Audit Logging
-- Business Validation Rules & Audit Log Triggers
-- ==========================================

-- 1. Create Audit Log Table
CREATE TABLE audit_log (
    audit_id    INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    operation   VARCHAR(10),
    table_name  VARCHAR(30),
    booking_id  INT,
    old_data    JSONB,
    new_data    JSONB,
    changed_at  TIMESTAMP DEFAULT NOW()
);  

-- 2. Audit Log Function & Trigger
CREATE OR REPLACE FUNCTION booking_audit_log()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO audit_log(operation, table_name, booking_id, new_data)
        VALUES('INSERT', 'bookings', NEW.booking_id, row_to_json(NEW));
        RETURN NEW;
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO audit_log(operation, table_name, booking_id, old_data, new_data)
        VALUES('UPDATE', 'bookings', NEW.booking_id, row_to_json(OLD), row_to_json(NEW));
        RETURN NEW;
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO audit_log(operation, table_name, booking_id, old_data)
        VALUES('DELETE', 'bookings', OLD.booking_id, row_to_json(OLD));
        RETURN OLD;
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER bookings_audit_trigger
AFTER INSERT OR UPDATE OR DELETE ON bookings
FOR EACH ROW EXECUTE FUNCTION booking_audit_log();

-- 3. Rating Validation Trigger
CREATE OR REPLACE FUNCTION validate_rating()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.rating IS NOT NULL AND (NEW.rating < 1 OR NEW.rating > 5) THEN
        RAISE EXCEPTION 'Rating must be between 1 and 5';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER rating_validation_trigger
BEFORE INSERT OR UPDATE ON bookings
FOR EACH ROW EXECUTE FUNCTION validate_rating();

-- 4. Prevent Double Rating Update Trigger
CREATE OR REPLACE FUNCTION prevent_rating_update()
RETURNS TRIGGER AS $$
BEGIN
    IF OLD.rating IS NOT NULL AND NEW.rating IS DISTINCT FROM OLD.rating THEN
        RAISE EXCEPTION 'Rating cannot be updated twice';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER prevent_rating_twice_trigger
BEFORE UPDATE ON bookings
FOR EACH ROW EXECUTE FUNCTION prevent_rating_update();