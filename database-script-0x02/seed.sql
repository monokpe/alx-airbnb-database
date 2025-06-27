-- Inserting sample data into User
INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role) VALUES
('123e4567-e89b-12d3-a456-426614174000', 'John', 'Doe', 'john.doe@email.com', '$2a$10$hashedpassword1', '123-456-7890', 'guest'),
('223e4567-e89b-12d3-a456-426614174001', 'Jane', 'Smith', 'jane.smith@email.com', '$2a$10$hashedpassword2', '234-567-8901', 'host'),
('323e4567-e89b-12d3-a456-426614174002', 'Alice', 'Brown', 'alice.brown@email.com', '$2a$10$hashedpassword3', NULL, 'guest'),
('423e4567-e89b-12d3-a456-426614174003', 'Bob', 'Johnson', 'bob.johnson@email.com', '$2a$10$hashedpassword4', '345-678-9012', 'host'),
('523e4567-e89b-12d3-a456-426614174004', 'Emma', 'Wilson', 'emma.wilson@email.com', '$2a$10$hashedpassword5', '456-789-0123', 'admin');

-- Inserting sample data into Property
INSERT INTO Property (property_id, host_id, name, description, location, pricepernight) VALUES
('623e4567-e89b-12d3-a456-426614174005', '223e4567-e89b-12d3-a456-426614174001', 'Cozy Downtown Loft', 'Modern loft in city center with great views', 'New York, NY', 150.00),
('723e4567-e89b-12d3-a456-426614174006', '223e4567-e89b-12d3-a456-426614174001', 'Beachfront Villa', 'Spacious villa with ocean view', 'Miami, FL', 250.00),
('823e4567-e89b-12d3-a456-426614174007', '423e4567-e89b-12d3-a456-426614174003', 'Mountain Cabin', 'Rustic cabin in the woods', 'Aspen, CO', 180.00),
('923e4567-e89b-12d3-a456-426614174008', '423e4567-e89b-12d3-a456-426614174003', 'Urban Apartment', 'Stylish apartment near downtown', 'Chicago, IL', 120.00);

-- Inserting sample data into Booking
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status) VALUES
('a23e4567-e89b-12d3-a456-426614174009', '623e4567-e89b-12d3-a456-426614174005', '123e4567-e89b-12d3-a456-426614174000', '2025-07-01', '2025-07-03', 300.00, 'confirmed'),
('b23e4567-e89b-12d3-a456-426614174010', '723e4567-e89b-12d3-a456-426614174006', '123e4567-e89b-12d3-a456-426614174000', '2025-08-01', '2025-08-05', 1000.00, 'pending'),
('c23e4567-e89b-12d3-a456-426614174011', '823e4567-e89b-12d3-a456-426614174007', '323e4567-e89b-12d3-a456-426614174002', '2025-07-15', '2025-07-18', 540.00, 'confirmed'),
('d23e4567-e89b-12d3-a456-426614174012', '923e4567-e89b-12d3-a456-426614174008', '323e4567-e89b-12d3-a456-426614174002', '2025-09-01', '2025-09-02', 120.00, 'canceled');

-- Inserting sample data into Payment
INSERT INTO Payment (payment_id, booking_id, amount, payment_method) VALUES
('e23e4567-e89b-12d3-a456-426614174013', 'a23e4567-e89b-12d3-a456-426614174009', 300.00, 'credit_card'),
('f23e4567-e89b-12d3-a456-426614174014', 'c23e4567-e89b-12d3-a456-426614174011', 540.00, 'paypal');

-- Inserting sample data into Review
INSERT INTO Review (review_id, property_id, user_id, rating, comment) VALUES
('g23e4567-e89b-12d3-a456-426614174015', '623e4567-e89b-12d3-a456-426614174005', '123e4567-e89b-12d3-a456-426614174000', 5, 'Amazing stay, great location!'),
('h23e4567-e89b-12d3-a456-426614174016', '823e4567-e89b-12d3-a456-426614174007', '323e4567-e89b-12d3-a456-426614174002', 4, 'Cozy cabin, perfect for a getaway.');

-- Inserting sample data into Message
INSERT INTO Message (message_id, sender_id, recipient_id, message_body) VALUES
('i23e4567-e89b-12d3-a456-426614174017', '123e4567-e89b-12d3-a456-426614174000', '223e4567-e89b-12d3-a456-426614174001', 'Is the loft available for July?'),
('j23e4567-e89b-12d3-a456-426614174018', '223e4567-e89b-12d3-a456-426614174001', '123e4567-e89b-12d3-a456-426614174000', 'Yes, it’s available. Would you like to book?');