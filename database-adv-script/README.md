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
