-- performance.sql

SELECT 
    b.id AS booking_id,
    b.booking_date,
    
    u.id AS user_id,
    u.name AS user_name,
    u.email AS user_email,

    p.id AS property_id,
    p.name AS property_name,
    p.location,

    pay.id AS payment_id,
    pay.amount,
    pay.payment_date

FROM bookings b
JOIN users u ON b.user_id = u.id
JOIN properties p ON b.property_id = p.id
JOIN payments pay ON b.payment_id = pay.id

WHERE b.booking_date >= '2024-01-01'
AND pay.status = 'completed';

-- This query retrieves booking details along with user, property, and payment information.
-- It joins the bookings, users, properties, and payments tables to provide a comprehensive view of the booking process.

EXPLAIN
SELECT 
    b.id AS booking_id,
    u.id AS user_id,
    u.name AS user_name,
    u.email AS user_email,
    p.id AS property_id,
    p.name AS property_name,
    p.location,
    pay.id AS payment_id,
    pay.amount,
    pay.status
FROM bookings b
JOIN users u ON b.user_id = u.id
JOIN properties p ON b.property_id = p.id
JOIN payments pay ON b.payment_id = pay.id;


-- Refactor the Query for Simplicity and Speed

-- Indexes to speed up JOINs
CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_bookings_payment_id ON bookings(payment_id);


