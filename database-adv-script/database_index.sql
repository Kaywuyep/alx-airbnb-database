-- Index creation for AirBnB Database
-- This script creates optimized indexes for User, Booking, and Property tables

-- User table indexes
-- Email is commonly used for login/authentication
CREATE INDEX idx_user_email ON User(email);
-- Name fields are often used in search and sorting operations
CREATE INDEX idx_user_lastname ON User(last_name);
-- If you frequently search users by status or role
CREATE INDEX idx_user_status ON User(status);

-- Booking table indexes
-- Foreign keys should be indexed for JOIN operations
CREATE INDEX idx_booking_user_id ON Booking(user_id);
CREATE INDEX idx_booking_property_id ON Booking(property_id);
-- Date ranges are common in booking systems for availability checks
CREATE INDEX idx_booking_dates ON Booking(check_in_date, check_out_date);
-- Status is often used in WHERE clauses (confirmed, cancelled, etc.)
CREATE INDEX idx_booking_status ON Booking(status);
-- Composite index for common query pattern
CREATE INDEX idx_booking_property_dates ON Booking(property_id, check_in_date, check_out_date);

-- Property table indexes
-- Location-based searches are very common
CREATE INDEX idx_property_location ON Property(city, country);
-- Price filtering is a standard feature
CREATE INDEX idx_property_price ON Property(price_per_night);
-- Property type filtering
CREATE INDEX idx_property_type ON Property(property_type);
-- Owner ID for joining with User table
CREATE INDEX idx_property_owner ON Property(owner_id);
-- Full-text search index if your database supports it (MySQL example)
-- CREATE FULLTEXT INDEX idx_property_fulltext ON Property(name, description);

-- Composite indexes for common filter combinations
CREATE INDEX idx_property_location_type ON Property(city, property_type);
CREATE INDEX idx_property_location_price ON Property(city, price_per_night);


-- Measure the query performance before and after adding indexes
-- EXPLAIN ANALYZE for Booking and Property Tables

EXPLAIN ANALYZE
SELECT p.*
FROM Property p
LEFT JOIN Booking b 
  ON p.id = b.property_id
  AND b.check_in_date <= '2025-06-15'
  AND b.check_out_date >= '2025-06-10'
  AND b.status = 'confirmed'
WHERE p.city = 'Paris'
  AND p.price_per_night BETWEEN 100 AND 300
  AND b.id IS NULL
ORDER BY p.price_per_night ASC;
