-- Index on the 'properties' table for efficient searching and filtering.
-- 1. Index on `pricepernight` to speed up range queries (e.g., finding properties
--    within a price range) and sorting by price.
CREATE INDEX idx_properties_pricepernight ON properties(pricepernight);

-- 2. Index on `location` to speed up searches for properties in a specific location.
--    Note: This is most effective for exact matches or left-anchored LIKE ('city%').
--    For full-text searching (LIKE '%city%'), a FULLTEXT index would be more suitable.
CREATE INDEX idx_properties_location ON properties(location);


-- Index on the 'bookings' table for critical business logic.
-- 3. Composite index for availability checks. This is the most important index.
--    It allows the database to quickly find bookings for a specific property
--    within a given date range, which is essential for preventing double-bookings.
--    The column order (property_id, start_date, end_date) is intentional for optimal performance.
CREATE INDEX idx_bookings_availability ON bookings(property_id, start_date, end_date);

-- 4. Index on `status` to quickly filter bookings by their current state (e.g.,
--    'pending', 'confirmed'). This is useful for admin dashboards and reports.
CREATE INDEX idx_bookings_status ON bookings(status);