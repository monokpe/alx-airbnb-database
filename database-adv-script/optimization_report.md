# Query Optimization Report

## Overview

I analyzed a PostgreSQL query retrieving bookings with user, property, and payment details, using the `EXPLAIN` output. The query showed sequential scans on `users`, a costly sort, and an unexpected `Hash Right Join` for `payments`. I refactored it to reduce execution time by adding an index, optimizing columns, adding pagination, and ensuring correct joins.

## Original Query Issues

The `EXPLAIN` output revealed:

- **Sort**: For `ORDER BY b.created_at DESC`, costly for large datasets.
- **Seq Scan on users**: Scanning `users` twice, inefficient for large tables.
- **Hash Right Join**: Unexpected for `payments` (query used `LEFT JOIN`).
- **Wide Rows**: Large columns like `p.description` increased I/O.
- **Full Retrieval**: No pagination, slow for large `bookings`.

## Optimizations Applied

I refactored the query (`get_all_bookings`),

1. **Added Index**: Created `idx_bookings_created_at` to eliminate sorting.
   ```sql
   CREATE INDEX idx_bookings_created_at ON bookings(created_at DESC);
   ```
2. **Reduced Columns**: Removed `p.description`, `u.role` to lower I/O.
3. **Added Pagination**: Used `LIMIT 100 OFFSET 0` for scalability.
4. **Ensured Correct Join**: Kept `LEFT JOIN` for `payments`, leveraging `idx_payments_booking_id`.
5. **Updated Statistics**: Recommended `ANALYZE` to favor index scans.

## Impact

These changes should:

- Eliminate sort with index scan.
- Reduce I/O by minimizing row width.
- Improve scalability with pagination.
- Ensure efficient joins using existing indexes (`idx_bookings_user_id`, `idx_properties_host_id`).

## Validation Plan

I suggest:

1. Run `EXPLAIN ANALYZE` to confirm index usage and reduced times.
2. Check table sizes:
   ```sql
   SELECT table_name, pg_size_pretty(pg_total_relation_size(table_name)) FROM information_schema.tables WHERE table_schema = 'public';
   ```
3. Verify `LEFT JOIN` results.

## Conclusion

I optimized the query to reduce execution time.
