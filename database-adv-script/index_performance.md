-- database_index.sql
-- SQL script for creating indexes to optimize query performance

-- First, let's identify high-usage columns in our tables:
-- Users table: user_id (primary key, used in joins), email (used in searches/login)
-- Bookings table: booking_id (PK), user_id (FK, joins), property_id (FK, joins), check_in_date, check_out_date (date filters)
-- Properties table: property_id (PK, joins), location_id (filters), price_per_night (range filters), is_available (boolean filters)
-- Reviews table: review_id (PK), property_id (FK, joins), user_id (FK, joins), rating (range filters)

-- Note: Primary keys typically already have indexes automatically created

-- ===== INDEXING STRATEGY =====

-- === USER TABLE INDEXES ===
-- Email is commonly used for login queries and should be unique
CREATE UNIQUE INDEX idx_users_email ON users(email);

-- If you frequently search users by name
CREATE INDEX idx_users_name ON users(last_name, first_name);

-- === BOOKING TABLE INDEXES ===
-- Foreign keys for JOIN operations
CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);

-- Date ranges are frequently used in booking queries
CREATE INDEX idx_bookings_dates ON bookings(check_in_date, check_out_date);

-- Compound index for queries that filter by property and date range
CREATE INDEX idx_bookings_property_dates ON bookings(property_id, check_in_date, check_out_date);

-- Index for status if you frequently query by booking status
CREATE INDEX idx_bookings_status ON bookings(status);

-- === PROPERTY TABLE INDEXES ===
-- Location searches are very common
CREATE INDEX idx_properties_location ON properties(location_id);

-- Price filtering is common in property searches
CREATE INDEX idx_properties_price ON properties(price_per_night);

-- Availability filtering (if applicable)
CREATE INDEX idx_properties_availability ON properties(is_available);

-- Compound index for common property search (location + price range + availability)
CREATE INDEX idx_properties_search ON properties(location_id, price_per_night, is_available);

-- === REVIEW TABLE INDEXES ===
-- Foreign keys for JOIN operations
CREATE INDEX idx_reviews_property_id ON reviews(property_id);
CREATE INDEX idx_reviews_user_id ON reviews(user_id);

-- Rating is often used for filtering and sorting
CREATE INDEX idx_reviews_rating ON reviews(rating);

-- Date index if you sort reviews by date
CREATE INDEX idx_reviews_date ON reviews(review_date);

-- ===== PERFORMANCE MEASUREMENT =====

-- To measure performance before adding indexes, run the following for your queries:
-- EXPLAIN ANALYZE SELECT * FROM bookings WHERE user_id = 123;

-- Example performance testing queries:

-- 1. Finding all bookings for a specific user
-- Before adding index:
EXPLAIN ANALYZE 
SELECT * FROM bookings WHERE user_id = 123;

-- 2. Finding available properties in a specific location and price range
-- Before adding index:
EXPLAIN ANALYZE
SELECT * FROM properties 
WHERE location_id = 456 
AND price_per_night BETWEEN 100 AND 200 
AND is_available = true;

-- 3. Finding properties with high ratings
-- Before adding index:
EXPLAIN ANALYZE
SELECT p.* FROM properties p
JOIN (
    SELECT property_id, AVG(rating) as avg_rating
    FROM reviews
    GROUP BY property_id
    HAVING AVG(rating) > 4.0
) r ON p.property_id = r.property_id;

-- 4. Finding bookings for a specific date range
-- Before adding index:
EXPLAIN ANALYZE
SELECT * FROM bookings
WHERE check_in_date <= '2023-08-31' 
AND check_out_date >= '2023-08-01';

-- After creating the indexes, run the same EXPLAIN ANALYZE commands again
-- and compare the execution plans and times to measure the performance improvement.

-- Note: In production environments, consider:
-- 1. Creating indexes during low-traffic periods
-- 2. Monitoring query performance with real-world data
-- 3. Regularly reviewing index usage with pg_stat_user_indexes (PostgreSQL)
-- 4. Removing unused indexes as they impact write performance