# Database Schema for an Airbnb-like Application

## Overview

This document outlines the database schema for an application similar to Airbnb. The schema is designed to store information about users, properties, bookings, payments, reviews, and messages.

## Tables

The database consists of the following tables:

* **User:** Stores user information, including personal details, authentication credentials, and roles.
* **Property:** Stores property details, including host information, description, location, and pricing.
* **Booking:** Stores booking information, including property and user details, dates, total price, and status.
* **Payment:** Stores payment information related to bookings.
* **Review:** Stores user reviews for properties.
* **Message:** Stores messages exchanged between users.

## Table Details

### User

| Column          | Data Type             | Constraints                                      | Description                                                              |
| :-------------- | :-------------------- | :----------------------------------------------- | :----------------------------------------------------------------------- |
| user\_id        | UUID                  | PRIMARY KEY                                      | Unique identifier for the user.                                          |
| first\_name      | VARCHAR(255)          | NOT NULL                                         | User's first name.                                                         |
| last\_name       | VARCHAR(255)          | NOT NULL                                         | User's last name.                                                          |
| email           | VARCHAR(255)          | UNIQUE, NOT NULL                                 | User's email address (must be unique).                                   |
| password\_hash  | VARCHAR(255)          | NOT NULL                                         | User's password hash.                                                      |
| phone\_number    | VARCHAR(20)           | NULL                                             | User's phone number.                                                       |
| role            | ENUM('guest', 'host', 'admin') | NOT NULL                                         | User's role in the application.                                          |
| created\_at      | TIMESTAMP             | DEFAULT CURRENT\_TIMESTAMP                       | Timestamp when the user account was created.                             |

### Property

| Column          | Data Type       | Constraints                                      | Description                                                              |
| :-------------- | :-------------- | :----------------------------------------------- | :----------------------------------------------------------------------- |
| property\_id    | UUID            | PRIMARY KEY                                      | Unique identifier for the property.                                      |
| host\_id        | UUID            | NOT NULL, FOREIGN KEY references User(user\_id) | Foreign key referencing the User table; identifies the host.             |
| name            | VARCHAR(255)    | NOT NULL                                         | Name of the property.                                                      |
| description     | TEXT            | NOT NULL                                         | Description of the property.                                               |
| location        | VARCHAR(255)    | NOT NULL                                         | Location of the property.                                                    |
| pricepernight   | DECIMAL(10, 2)  | NOT NULL                                         | Price per night for the property.                                          |
| created\_at      | TIMESTAMP       | DEFAULT CURRENT\_TIMESTAMP                       | Timestamp when the property was created.                                   |
| updated\_at      | TIMESTAMP       | ON UPDATE CURRENT\_TIMESTAMP                     | Timestamp when the property was last updated.                              |

### Booking

| Column          | Data Type       | Constraints                                                                                                | Description                                                                      |
| :-------------- | :-------------- | :--------------------------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------- |
| booking\_id     | UUID            | PRIMARY KEY                                                                                                | Unique identifier for the booking.                                           |
| property\_id    | UUID            | NOT NULL, FOREIGN KEY references Property(property\_id)                                                    | Foreign key referencing the Property table.                                    |
| user\_id        | UUID            | NOT NULL, FOREIGN KEY references User(user\_id)                                                            | Foreign key referencing the User table; identifies the booker.                   |
| start\_date      | DATE            | NOT NULL                                                                                                   | Start date of the booking.                                                       |
| end\_date        | DATE            | NOT NULL                                                                                                   | End date of the booking.                                                         |
| total\_price    | DECIMAL(10, 2)  | NOT NULL                                                                                                   | Total price of the booking.                                                      |
| status          | ENUM('pending', 'confirmed', 'canceled') | NOT NULL, CHECK (status IN ('pending', 'confirmed', 'canceled')) | Status of the booking.                                                         |
| created\_at      | TIMESTAMP       | DEFAULT CURRENT\_TIMESTAMP                                                                                 | Timestamp when the booking was created.                                        |

### Payment

| Column          | Data Type             | Constraints                                      | Description                                                              |
| :-------------- | :-------------------- | :----------------------------------------------- | :----------------------------------------------------------------------- |
| payment\_id     | UUID                  | PRIMARY KEY                                      | Unique identifier for the payment.                                       |
| booking\_id     | UUID                  | NOT NULL, FOREIGN KEY references Booking(booking\_id) | Foreign key referencing the Booking table.                                   |
| amount          | DECIMAL(10, 2)        | NOT NULL                                         | Amount paid.                                                             |
| payment\_date    | TIMESTAMP             | DEFAULT CURRENT\_TIMESTAMP                       | Timestamp when the payment was made.                                     |
| payment\_method  | ENUM('credit\_card', 'paypal', 'stripe') | NOT NULL                                         | Method used for payment.                                                       |

### Review

| Column          | Data Type       | Constraints                                                                  | Description                                                              |
| :-------------- | :-------------- | :--------------------------------------------------------------------------- | :----------------------------------------------------------------------- |
| review\_id      | UUID            | PRIMARY KEY                                                                  | Unique identifier for the review.                                        |
| property\_id    | UUID            | NOT NULL, FOREIGN KEY references Property(property\_id)                      | Foreign key referencing the Property table.                                    |
| user\_id        | UUID            | NOT NULL, FOREIGN KEY references User(user\_id)                              | Foreign key referencing the User table; identifies the reviewer.                   |
| rating          | INTEGER         | NOT NULL, CHECK (rating >= 1 AND rating <= 5)                                | Rating given by the user (1-5).                                          |
| comment         | TEXT            | NOT NULL                                                                     | User's review comment.                                                       |
| created\_at      | TIMESTAMP       | DEFAULT CURRENT\_TIMESTAMP                                                   | Timestamp when the review was created.                                     |

### Message

| Column          | Data Type       | Constraints                                      | Description                                                              |
| :-------------- | :-------------- | :----------------------------------------------- | :----------------------------------------------------------------------- |
| message\_id      | UUID            | PRIMARY KEY                                      | Unique identifier for the message.                                       |
| sender\_id      | UUID            | NOT NULL, FOREIGN KEY references User(user\_id)    | Foreign key referencing the User table; identifies the sender.             |
| recipient\_id    | UUID            | NOT NULL, FOREIGN KEY references User(user\_id)  | Foreign key referencing the User table; identifies the recipient.          |
| message\_body    | TEXT            | NOT NULL                                         | Content of the message.                                                    |
| sent\_at        | TIMESTAMP       | DEFAULT CURRENT\_TIMESTAMP                       | Timestamp when the message was sent.                                       |

## Indexes

The following indexes are defined to improve query performance:

* `idx_user_email` on the `email` column of the `User` table.
* `idx_property_id` on the `property_id` column of the `Property` table.
* `idx_booking_property_id` on the `property_id` column of the `Booking` table.
* `idx_payment_booking_id` on the `booking_id` column of the `Payment` table.

## Relationships

The tables in this database have the following relationships:

* A user can host multiple properties (one-to-many relationship between `User` and `Property`).
* A user can make multiple bookings (one-to-many relationship between `User` and `Booking`).
* A property can have multiple bookings (one-to-many relationship between `Property` and `Booking`).
* A booking has one payment (one-to-one relationship between `Booking` and `Payment`).
* A property can have multiple reviews (one-to-many relationship between `Property` and `Review`).
* A user can write multiple reviews (one-to-many relationship between `User` and `Review`).
* A user can send and receive multiple messages (one-to-many relationship between `User` and `Message` for both sender and recipient).
