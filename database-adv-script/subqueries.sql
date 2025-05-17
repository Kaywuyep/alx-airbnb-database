-- Non-correlated Subquery to Find Properties with Average Rating > 4.0

SELECT 
    p.property_id,
    p.property_name,
    p.address,
    p.price_per_night
FROM 
    properties p
WHERE 
    p.property_id IN (
        SELECT 
            r.property_id
        FROM 
            reviews r
        GROUP BY 
            r.property_id
        HAVING 
            AVG(r.rating) > 4.0
    )
ORDER BY 
    p.property_id;

-- Correlated Subquery to Find Users with More Than 3 Bookings

SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email
FROM 
    users u
WHERE (
    SELECT 
        COUNT(*)
    FROM 
        bookings b
    WHERE 
        b.user_id = u.user_id
) > 3
ORDER BY 
    u.user_id;