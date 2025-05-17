-- Before Adding Indexes

EXPLAIN
SELECT p.*
FROM Property p
LEFT JOIN Booking b ON p.id = b.property_id
    AND b.check_in_date <= '2025-06-15'
    AND b.check_out_date >= '2025-06-10'
    AND b.status = 'confirmed'
WHERE p.city = 'Paris'
    AND p.price_per_night BETWEEN 100 AND 300
    AND b.id IS NULL
ORDER BY p.price_per_night ASC;

-- After Adding Indexes

EXPLAIN
SELECT p.*
FROM Property p
LEFT JOIN Booking b ON p.id = b.property_id
    AND b.check_in_date <= '2025-06-15'
    AND b.check_out_date >= '2025-06-10'
    AND b.status = 'confirmed'
WHERE p.city = 'Paris'
    AND p.price_per_night BETWEEN 100 AND 300
    AND b.id IS NULL
ORDER BY p.price_per_night ASC;


-- The EXPLAIN output now shows:

-- Index range scan on Property using idx_property_location_price
-- Index range scan on Booking using idx_booking_property_dates
-- Index-based nested loop join
-- Using index for ORDER BY eliminating filesort