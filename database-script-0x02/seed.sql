-- Insert sample data into the User table
INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at)
VALUES
    ('74214b34-4091-49b7-8991-98199995917e', 'John', 'Doe', 'john.doe@example.com', 'hashed_password_1', '123-456-7890', 'guest', NOW()),
    ('b9e58f31-b874-4192-b582-29461495917f', 'Jane', 'Smith', 'jane.smith@example.com', 'hashed_password_2', '987-654-3210', 'host', NOW()),
    ('3133c919-9749-4159-a993-98200006328a', 'Alice', 'Johnson', 'alice.johnson@example.com', 'hashed_password_3', '555-123-4567', 'guest', NOW()),
    ('a1b2c3d4-e5f6-4789-9012-345678901234', 'Bob', 'Williams', 'bob.williams@example.com', 'hashed_password_4', '444-555-6666', 'host', NOW()),
    ('56789a0b-c2d3-4ef5-6789-0123456789ab', 'Admin', 'User', 'admin@example.com', 'admin_password_hash', '111-222-3333', 'admin', NOW());

-- Insert sample data into the Property table
INSERT INTO Property (property_id, host_id, name, description, location, pricepernight, created_at, updated_at)
VALUES
    ('f1234567-89ab-4cde-f012-3456789abcdef', 'b9e58f31-b874-4192-b582-29461495917f', 'Cozy Apartment', 'A beautiful apartment in the heart of the city.', 'New York, NY', 150.00, NOW(), NOW()),
    ('g2345678-90bc-4def-f123-456789abcdef1', 'b9e58f31-b874-4192-b582-29461495917f', 'Luxury Villa', 'A spacious villa with a private pool and ocean view.', 'Los Angeles, CA', 300.00, NOW(), NOW()),
    ('h3456789-01cd-5efa-0123-56789abcdef2', 'a1b2c3d4-e5f6-4789-9012-345678901234', 'Rustic Cabin', 'A charming cabin in the mountains.', 'Denver, CO', 100.00, NOW(), NOW()),
    ('i4567890-12de-6fab-1234-56789abcdef3', 'a1b2c3d4-e5f6-4789-9012-345678901234', 'Beachfront Condo', 'A modern condo with direct beach access.', 'Miami, FL', 200.00, NOW(), NOW()),
    ('j5678901-23ef-7abc-2345-6789abcdef4', 'b9e58f31-b874-4192-b582-29461495917f', 'Downtown Loft', 'A stylish loft in the city center', 'Chicago, IL', 175.00, NOW(), NOW());

-- Insert sample data into the Booking table
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at)
VALUES
    ('k1234567-89ab-4cde-f012-3456789abcde1', 'f1234567-89ab-4cde-f012-3456789abcdef', '74214b34-4091-49b7-8991-98199995917e', '2024-01-15', '2024-01-22', 1050.00, 'confirmed', NOW()),
    ('l2345678-90bc-4def-f123-456789abcde2', 'g2345678-90bc-4def-f123-456789abcdef1', '3133c919-9749-4159-a993-98200006328a', '2024-02-01', '2024-02-08', 2100.00, 'confirmed', NOW()),
    ('m3456789-01cd-5efa-0123-56789abcde3', 'h3456789-01cd-5efa-0123-56789abcdef2', '74214b34-4091-49b7-8991-98199995917e', '2024-03-10', '2024-03-17', 700.00, 'canceled', NOW()),
    ('n4567890-12de-6fab-1234-56789abcde4', 'i4567890-12de-6fab-1234-56789abcdef3', '3133c919-9749-4159-a993-98200006328a', '2024-04-01', '2024-04-05', 800.00, 'pending', NOW()),
     ('o5678901-23ef-7abc-2345-6789abcde5', 'f1234567-89ab-4cde-f012-3456789abcdef', '74214b34-4091-49b7-8991-98199995917e', '2024-05-01', '2024-05-07', 900, 'confirmed', NOW());

-- Insert sample data into the Payment table
INSERT INTO Payment (payment_id, booking_id, amount, payment_date, payment_method)
VALUES
    ('p1234567-89ab-4cde-f012-3456789abcdf1', 'k1234567-89ab-4cde-f012-3456789abcde1', 1050.00, NOW(), 'credit_card'),
    ('q2345678-90bc-4def-f123-456789abcdf2', 'l2345678-90bc-4def-f123-456789abcde2', 2100.00, NOW(), 'paypal'),
    ('r3456789-01cd-5efa-0123-56789abcdf3', 'm3456789-01cd-5efa-0123-56789abcde3', 700.00, NOW(), 'credit_card'),
    ('s4567890-12de-6fab-1234-56789abcdf4', 'n4567890-12de-6fab-1234-56789abcde4', 800.00, NOW(), 'stripe'),
    ('t5678901-23ef-7abc-2345-6789abcdf5', 'o5678901-23ef-7abc-2345-6789abcde5', 900.00, NOW(), 'paypal');

-- Insert sample data into the Review table
INSERT INTO Review (review_id, property_id, user_id, rating, comment, created_at)
VALUES
    ('u1234567-89ab-4cde-f012-3456789abcde6', 'f1234567-89ab-4cde-f012-3456789abcdef', '74214b34-4091-49b7-8991-98199995917e', 4, 'Great place to stay!', NOW()),
    ('v2345678-90bc-4def-f123-456789abcde7', 'g2345678-90bc-4def-f123-456789abcdef1', '3133c919-9749-4159-a993-98200006328a', 5, 'Amazing villa with stunning views.', NOW()),
    ('w3456789-01cd-5efa-0123-56789abcde8', 'h3456789-01cd-5efa-0123-56789abcdef2', '74214b34-4091-49b7-8991-98199995917e', 3, 'Cozy cabin, but a bit remote.', NOW()),
    ('x4567890-12de-6fab-1234-56789abcde9', 'i4567890-12de-6fab-1234-56789abcdef3', '3133c919-9749-4159-a993-98200006328a', 4, 'Great location and nice condo.', NOW()),
    ('y5678901-23ef-7abc-2345-6789abcdea', 'f1234567-89ab-4cde-f012-3456789abcdef', '74214b34-4091-49b7-8991-98199995917e', 5, 'Excellent stay, highly recommended', NOW());

-- Insert sample data into the Message table
INSERT INTO Message (message_id, sender_id, recipient_id, message_body, sent_at)
VALUES
    ('z1234567-89ab-4cde-f012-3456789abcdff', '74214b34-4091-49b7-8991-98199995917e', 'b9e58f31-b874-4192-b582-29461495917f', 'Hello, I have a question about your property.', NOW()),
    ('aa234567-90bc-4def-f123-456789abdc00', 'b9e58f31-b874-4192-b582-29461495917f', '74214b34-4091-49b7-8991-98199995917e', 'Yes, of course. What would you like to know?', NOW()),
    ('bb345678-01cd-5efa-0123-56789abdc01', '3133c919-9749-4159-a993-98200006328a', 'a1b2c3d4-e5f6-4789-9012-345678901234', 'Is the property pet-friendly?', NOW()),
    ('cc456789-12de-6fab-1234-56789abdc02', 'a1b2c3d4-e5f6-4789-9012-345678901234', '3133c919-9749-4159-a993-98200006328a', 'Yes, it is pet-friendly.', NOW()),
    ('dd567890-23ef-7abc-2345-6789abdc03', '74214b34-4091-49b7-8991-98199995917e', 'b9e58f31-b874-4192-b582-29461495917f', 'Thank you for your quick response.', NOW());
