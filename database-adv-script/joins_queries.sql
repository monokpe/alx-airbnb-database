-- 1. INNER JOIN: Retrieve all bookings and the respective users who made those bookings.
SELECT
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email
FROM
    bookings AS b
INNER JOIN
    users AS u ON b.user_id = u.user_id;

-- 2. LEFT JOIN: Retrieve all properties and their reviews, including properties that have no reviews.
SELECT
    p.property_id,
    p.name AS property_name,
    p.description,
    p.location,
    p.pricepernight,
    r.review_id,
    r.rating,
    r.comment,
    r.created_at AS review_date
FROM
    properties AS p
LEFT JOIN
    reviews AS r ON p.property_id = r.property_id
ORDER BY
    r.review_id IS NOT NULL DESC, -- Orders properties with reviews first
    p.property_id; -- Secondary sort to ensure consistent ordering among reviewed/unreviewed properties


-- 3. FULL OUTER JOIN: Retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user.
SELECT
    u.user_id,
    u.first_name,
    u.last_name,
    b.booking_id,
    b.start_date,
    b.end_date,
    b.status
FROM
    users AS u
FULL OUTER JOIN
    bookings AS b ON u.user_id = b.user_id;