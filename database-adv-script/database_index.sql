-- I put this script together to test how indexes can speed up my database queries.
-- Here's what it does:
-- 1. Runs EXPLAIN ANALYZE on a slow query to see how it performs without indexes.
-- 2. Adds some indexes to optimize the query.
-- 3. Runs EXPLAIN ANALYZE again to compare the performance with the new indexes.
--
-- Note: I made sure to have some sample data in my tables before running this.

-- === 1. Checking Performance Before Indexes ===
--
-- I started with a query to check booking availability for a specific property in a date range.
-- Without the right indexes, I figured this would be slow, scanning way more rows than needed.
--
-- I’m expecting the EXPLAIN output to show a high "actual time" and no dedicated index for filtering dates.

EXPLAIN ANALYZE
SELECT booking_id, start_date, end_date
FROM bookings
WHERE
    property_id = 'a1b2c3d4-e5f6-7890-1234-567890abcdef' -- Just using a sample UUID
    AND status = 'confirmed'
    AND start_date <= '2025-07-15'
    AND end_date >= '2025-07-18';


-- === 2. Adding the Indexes ===
--
-- Next, I added some indexes to speed up searches, filters, and joins I know I’ll use a lot.

-- Indexes for the 'properties' table to make price and location searches faster.
CREATE INDEX idx_properties_pricepernight ON properties(pricepernight);
CREATE INDEX idx_properties_location ON properties(location);

-- This composite index is the big one for the availability query above.
-- I ordered the columns carefully to help the database filter efficiently.
CREATE INDEX idx_bookings_availability ON bookings(property_id, start_date, end_date);

-- Added an index on booking status for quick filtering, like when I need to check pending bookings.
CREATE INDEX idx_bookings_status ON bookings(status);


-- === 3. Checking Performance After Indexes ===
--
-- I ran the same query again to see how the indexes helped.
--
-- I’m hoping to see:
--   -> The database using my new 'idx_bookings_availability' index.
--   -> A much lower "actual time" for the query.
--   -> Fewer rows being scanned.
--   -> The plan switching to a faster `Index Range Scan`.

EXPLAIN ANALYZE
SELECT booking_id, start_date, end_date
FROM bookings
WHERE
    property_id = 'a1b2c3d4-e5f6-7890-1234-567890abcdef' -- Same sample UUID
    AND status = 'confirmed'
    AND start_date <= '2024-01-31'
    AND end_date >= '2024-01-01';