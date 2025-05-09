ER Diagram Relationships

1. User ↔ Property

A user can be a host of many properties (One-to-Many relationship from User to Property).

2. User ↔ Booking

A user can make many bookings, but each booking is made by one user (One-to-Many relationship from User to Booking).

3. Property ↔ Booking

A property can have many bookings, but each booking corresponds to one property (One-to-Many relationship from Property to Booking).

4. Booking ↔ Payment

Each booking can have one payment associated with it, but a payment corresponds to one booking (One-to-One relationship from Booking to Payment).

5. User ↔ Review

A user can write many reviews, but each review is written by one user (One-to-Many relationship from User to Review).

6. Property ↔ Review

A property can have many reviews, but each review corresponds to one property (One-to-Many relationship from Property to Review).

7. User ↔ Message

A user can send and receive many messages. Each message has a sender and a recipient (Many-to-Many relationship via Message).


![alt text](<ER DIAGRAM.png>)