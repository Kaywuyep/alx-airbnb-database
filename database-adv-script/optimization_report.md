## ✅ Query Optimization Report
### Objective:
Optimize a SQL query that retrieves all bookings along with user, property, and payment details by analyzing and refactoring it for better performance.

🔹 1. Initial Query
The original query joins the bookings, users, properties, and payments tables to retrieve complete booking information:

🔹 2. Performance Analysis Using EXPLAIN
Observations:
Full table scans occurred on the users, properties, and payments tables.

No indexes were being used on the join columns (user_id, property_id, payment_id).

The query retrieved more rows than needed in some cases due to inefficient joins.

🔹 3. Optimization Strategy
To improve the performance:

✅ a. Index Creation
We added indexes to speed up the JOIN operations by allowing the database to quickly match foreign keys.

✅ b. Avoided SELECT *
Instead of selecting all columns, only necessary fields were retrieved, reducing data load and memory usage.

🔹 4. Final Query (Optimized)
The optimized query remains simple but runs faster thanks to indexing:

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
🔹 5. Result
After optimization:

Execution time decreased significantly.

Joins now use indexes, avoiding full table scans.

Query is clean, readable, and maintains the same functionality.

✅ Conclusion
By analyzing the execution plan and applying basic indexing and field selection principles, we were able to greatly improve the performance of the booking data query. No changes to business logic were required, keeping the query simple and effective.

