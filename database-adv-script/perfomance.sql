EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    b.created_at AS booking_created_at,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    u.role,
    p.property_id,
    p.name AS property_name,
    p.location,
    p.pricepernight,
    p.description,
    h.user_id AS host_id,
    h.first_name AS host_first_name,
    h.last_name AS host_last_name,
    pm.payment_id,
    pm.amount AS payment_amount,
    pm.payment_date,
    pm.payment_method
FROM 
    bookings b
    INNER JOIN users u ON b.user_id = u.user_id
    INNER JOIN properties p ON b.property_id = p.property_id
    INNER JOIN users h ON p.host_id = h.user_id
    LEFT JOIN payments pm ON b.booking_id = pm.booking_id
ORDER BY 
    b.created_at DESC;

-- Add index to support ORDER BY
CREATE INDEX idx_bookings_created_at ON bookings(created_at DESC);

-- Refactored query with optimized columns and pagination
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    b.created_at AS booking_created_at,
    u.user_id AS guest_id,
    u.first_name AS guest_first_name,
    u.last_name AS guest_last_name,
    u.email AS guest_email,
    p.property_id,
    p.name AS property_name,
    p.location,
    p.pricepernight,
    h.user_id AS host_id,
    h.first_name AS host_first_name,
    h.last_name AS host_last_name,
    pm.payment_id,
    pm.amount AS payment_amount,
    pm.payment_date,
    pm.payment_method
FROM 
    bookings b
    INNER JOIN users u ON b.user_id = u.user_id
    INNER JOIN properties p ON b.property_id = p.property_id
    INNER JOIN users h ON p.host_id = h.user_id
    LEFT JOIN payments pm ON b.booking_id = pm.booking_id
ORDER BY 
    b.created_at DESC
LIMIT 100 OFFSET 0;