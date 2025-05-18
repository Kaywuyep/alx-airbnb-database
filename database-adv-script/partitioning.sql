-- Partitioning solution for the Booking table
-- This script implements partitioning by the start_date column

-- 1. First, we need to create a new partitioned table structure
CREATE TABLE booking_partitioned (
    id SERIAL,
    property_id INTEGER NOT NULL,
    guest_id INTEGER NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price NUMERIC(10, 2) NOT NULL,
    status VARCHAR(20) NOT NULL,
    booking_date TIMESTAMP NOT NULL,
    last_updated TIMESTAMP,
    PRIMARY KEY(id, start_date)
) PARTITION BY RANGE (start_date);

-- 2. Create partitions by quarter
-- This allows for efficient queries on specific date ranges
CREATE TABLE booking_q1_2023 PARTITION OF booking_partitioned
    FOR VALUES FROM ('2023-01-01') TO ('2023-04-01');

CREATE TABLE booking_q2_2023 PARTITION OF booking_partitioned
    FOR VALUES FROM ('2023-04-01') TO ('2023-07-01');

CREATE TABLE booking_q3_2023 PARTITION OF booking_partitioned
    FOR VALUES FROM ('2023-07-01') TO ('2023-10-01');

CREATE TABLE booking_q4_2023 PARTITION OF booking_partitioned
    FOR VALUES FROM ('2023-10-01') TO ('2024-01-01');

CREATE TABLE booking_q1_2024 PARTITION OF booking_partitioned
    FOR VALUES FROM ('2024-01-01') TO ('2024-04-01');

CREATE TABLE booking_q2_2024 PARTITION OF booking_partitioned
    FOR VALUES FROM ('2024-04-01') TO ('2024-07-01');

CREATE TABLE booking_q3_2024 PARTITION OF booking_partitioned
    FOR VALUES FROM ('2024-07-01') TO ('2024-10-01');

CREATE TABLE booking_q4_2024 PARTITION OF booking_partitioned
    FOR VALUES FROM ('2024-10-01') TO ('2025-01-01');

CREATE TABLE booking_q1_2025 PARTITION OF booking_partitioned
    FOR VALUES FROM ('2025-01-01') TO ('2025-04-01');

CREATE TABLE booking_q2_2025 PARTITION OF booking_partitioned
    FOR VALUES FROM ('2025-04-01') TO ('2025-07-01');

-- 3. Add a default partition for dates outside our defined ranges
CREATE TABLE booking_default PARTITION OF booking_partitioned DEFAULT;

-- 4. Create indexes on the partitioned table
-- Index on the partition key for range scans
CREATE INDEX idx_booking_partitioned_start_date ON booking_partitioned (start_date);

-- Additional indexes for common query patterns
CREATE INDEX idx_booking_partitioned_property_id ON booking_partitioned (property_id);
CREATE INDEX idx_booking_partitioned_guest_id ON booking_partitioned (guest_id);
CREATE INDEX idx_booking_partitioned_status ON booking_partitioned (status);
CREATE INDEX idx_booking_partitioned_date_range ON booking_partitioned (start_date, end_date);

-- 5. Migrate data from the original table to the partitioned table
-- Note: This should be done during a maintenance window to minimize disruption
INSERT INTO booking_partitioned 
SELECT * FROM booking;

-- 6. Rename tables to complete the migration
-- Note: This requires exclusive lock on the tables
ALTER TABLE booking RENAME TO booking_old;
ALTER TABLE booking_partitioned RENAME TO booking;

-- 7. Sample queries to test performance with EXPLAIN ANALYZE

-- Query 1: Get bookings for a specific date range
EXPLAIN ANALYZE
SELECT * FROM booking
WHERE start_date BETWEEN '2023-06-01' AND '2023-08-31'
ORDER BY start_date;

-- Query 2: Get bookings for a specific property in a date range
EXPLAIN ANALYZE
SELECT * FROM booking
WHERE property_id = 123
AND start_date BETWEEN '2023-06-01' AND '2023-08-31'
ORDER BY start_date;

-- Query 3: Get bookings for a specific guest
EXPLAIN ANALYZE
SELECT * FROM booking
WHERE guest_id = 456
AND start_date >= '2023-01-01'
ORDER BY start_date;

-- Query 4: Get active bookings for the current quarter
EXPLAIN ANALYZE
SELECT * FROM booking
WHERE status = 'confirmed'
AND start_date BETWEEN '2023-07-01' AND '2023-09-30'
ORDER BY start_date;