## Database Normalization to Third Normal Form (3NF)

Based on the provided database schema for the property booking system was reviewed to ensure it adheres to the principles of the Third Normal Form (3NF).

**Initial Assessment:**

Upon initial examination, the schema appears to be well-structured and largely compliant with 3NF. Each table has a defined primary key, and the non-key attributes within each table are directly dependent on their respective primary keys. Foreign keys are used appropriately to establish relationships between tables.

**Detailed Entity Analysis:**

* **User:** The attributes `first_name`, `last_name`, `email`, `password_hash`, `phone_number`, and `role` all directly describe the user identified by `user_id`. There are no transitive dependencies.
* **Property:** The attributes `host_id`, `name`, `description`, `location`, and `pricepernight` directly describe the property identified by `property_id`.
* **Booking:** The attributes `property_id`, `user_id`, `start_date`, `end_date`, `total_price`, and `status` are all directly related to the specific booking identified by `booking_id`.
* **Payment:** The attributes `booking_id`, `amount`, `payment_date`, and `payment_method` directly pertain to the payment identified by `payment_id`.
* **Review:** The attributes `property_id`, `user_id`, `rating`, and `comment` are directly associated with the review identified by `review_id`.
* **Message:** The attributes `sender_id`, `recipient_id`, `message_body`, and `sent_at` are directly related to the message identified by `message_id`.

**Relationships and Foreign Keys:**

The defined relationships are implemented using foreign keys, which correctly link related entities without introducing redundancy that would violate normalization principles. For example, the `host_id` in the `Property` table establishes the relationship with the `User` table, ensuring that each property is associated with a host without duplicating user information within the `Property` table.

**Conclusion:**

Based on this analysis, the provided database schema is already in the Third Normal Form (3NF). No modifications are necessary to meet this normalization level. The schema effectively minimizes data redundancy and ensures that data dependencies are logical and consistent.