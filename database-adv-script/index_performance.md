## Database Index Performance Analysis
### Introduction
This document analyzes the performance improvements achieved by adding strategic indexes to the User, Booking, and Property tables in our AirBnB clone database. Proper indexing is critical for maintaining performance as database size grows.
High-Usage Columns Identified
#### User Table

email: Used for authentication and unique user identification
last_name: Used in user search and sorting operations
status: Used for filtering active/inactive users

#### Booking Table

user_id: Foreign key for joining with User table
property_id: Foreign key for joining with Property table
check_in_date and check_out_date: Used for availability searches
status: Filtered for booking status (confirmed, pending, cancelled)

#### Property Table

city and country: Location-based searches
price_per_night: Price range filtering
property_type: Property category filtering
owner_id: Foreign key for joining with User table
name and description: Text search operations