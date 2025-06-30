-- Query to find all properties where the average rating is greater than 4.0 using a subquery.
SELECT
    p.property_id,
    p.name,
    p.location,
    p.pricepernight
FROM
    properties AS p
WHERE
    p.property_id IN (
        SELECT
            r.property_id
        FROM
            reviews AS r
        GROUP BY
            r.property_id
        HAVING
            AVG(r.rating) > 4.0
    );

-- Correlated subquery to find users who have made more than 3 bookings.
SELECT
    u.user_id,
    u.first_name,
    u.last_name,
    u.email
FROM
    users AS u
WHERE
    (SELECT COUNT(*)
     FROM bookings AS b
     WHERE b.user_id = u.user_id) > 3;