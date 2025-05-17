#### SQL Joins Guide
This repository contains examples of different SQL join types to help you master the concept of joining tables in SQL.
Overview
SQL joins are operations that allow you to combine rows from two or more tables based on a related column. This guide covers the most common types of joins with practical examples using a vacation rental database schema.
Database Schema
The examples use the following simplified tables:

users: People who can book properties
properties: Rental properties available for booking
bookings: Reservations made by users for properties
reviews: Feedback left by users for properties they've booked

Types of Joins
1. INNER JOIN
Returns only the rows where there's a match in both tables.
Use case: Get all bookings and the respective users who made those bookings.
2. LEFT JOIN
Returns all rows from the left table and the matched rows from the right table.
Use case: Get all properties and their reviews, including properties that have no reviews.
3. FULL OUTER JOIN
Returns all rows when there's a match in either of the tables.
4. RIGHT JOIN
Similar to LEFT JOIN but returns all rows from the right table and the matched rows from the left table.

Join Visualizations
INNER JOIN
------------
   A ∩ B
------------
    ###
   #####
  ## | ##
 ##  |  ##
##   |   ##
 ##  |  ##
  ## | ##
   #####
    ###
LEFT JOIN
------------
    A
------------
    ###
   #####
  #######
 #########
###########
 #########
  #######
   #####
    ###
FULL OUTER JOIN
------------
   A ∪ B
------------
    ###
   #####
  #######
 #########
###########
 #########
  #######
   #####
    ###
Best Practices

Always use table aliases for better readability
Be explicit about join conditions
Consider the performance impact of different join types
Use appropriate indexes on join columns
Test your queries with different data scenarios

##### Subqueries

Non-correlated Subquery: Key characteristics are the inner query can run independently and doesn't reference the outer query.
Correlated Subquery: Key characteristics are the inner query references the outer query (note b.user_id = u.user_id) and is executed once for each row processed by the outer query.

##### My aggregation query uses:

Joins the users and bookings tables
Uses COUNT() to calculate the total bookings per user
Uses GROUP BY to aggregate results by user
Uses LEFT JOIN to include users with no bookings (they'll have a count of 0)
Orders results by number of bookings in descending order

Query 2: Ranking Properties by Number of Bookings (Window Functions)
This query:

Uses COUNT() to calculate the total bookings per property
Uses the window function ROW_NUMBER() to assign a unique sequential rank to each property
Properties with the most bookings get the lowest rank numbers (1, 2, 3, etc.)

**The difference between ROW_NUMBER() and RANK() is that:**

ROW_NUMBER() always assigns sequential numbers (1, 2, 3, 4...)
RANK() assigns the same rank to ties and skips the next rank (1, 1, 3, 4...)

For example, if two properties both have 10 bookings (tied for most), RANK() would give them both rank 1, and the next property would get rank 3.