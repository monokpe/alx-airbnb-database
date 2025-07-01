### 1. Identifying High-Usage Columns

Based on my schema and common application logic (like searching, filtering, and checking availability), I’ve identified the key columns that would benefit most from new indexes. My existing indexes on primary and foreign keys are already solid, so I’m focusing on _new_ opportunities.

- **`properties.pricepernight`**: I know users will constantly filter and sort by price. Queries like `WHERE pricepernight BETWEEN 100 AND 200` or `ORDER BY pricepernight ASC` will be common, and without an index, they’ll be slow.
- **`properties.location`**: This is the primary search vector for properties. While a `LIKE '%city%'` search can’t effectively use a standard B-Tree index, indexing this column is critical for exact matches or `LIKE 'city%'` searches. For full-text search capabilities, I’d find a `FULLTEXT` index even more effective.
- **`bookings.start_date` and `bookings.end_date`**: These are arguably the **most critical missing indexes**. The most frequent and performance-sensitive query on the `bookings` table will involve checking for date overlaps to determine if a property is available. This requires checking both dates for a specific property, so I’d benefit greatly from a composite (multi-column) index here.
- **`bookings.status`**: This is useful for administrative views or dashboards, like when I need to see all pending bookings. Since the number of distinct statuses is low (low cardinality), this index offers a moderate benefit but is still worth implementing if I run such queries often.

### 2. Measuring Performance Before and After Indexing

To understand the impact of indexing, I decided to use `EXPLAIN` on a query that was running slowly. I expected the most significant improvement to come from adding a composite index to the `bookings` table.

I chose to analyze a query that checks for booking availability for a specific property within a date range.

# Analyzing Query Performance

I started by analyzing a query to check for booking availability for a specific property in January 2024.

**The Query I Analyzed:**

```sql
-- Find any confirmed bookings for property_id 'some-uuid' that overlap with January 2024.
SELECT booking_id, start_date, end_date
FROM bookings
WHERE
    property_id = 'a1b2c3d4-e5f6-7890-1234-567890abcdef' -- Example UUID
    AND status = 'confirmed'
    AND start_date <= '2024-01-31' -- The potential new booking ends after the existing one starts
    AND end_date >= '2024-01-01';  -- The potential new booking starts before the existing one ends
```

---

#### **What I Observed BEFORE Adding the Index**

Before adding any new indexes, I ran `EXPLAIN` on this query to see how MySQL was handling it.

**Command I Ran:**
`EXPLAIN SELECT ... ;` (using the query above)

**What `EXPLAIN` Showed (Simplified):**

| id  | select_type | table    | type | possible_keys            | key                      | key_len | ref   | rows | Extra           |
| --- | ----------- | -------- | ---- | ------------------------ | ------------------------ | ------- | ----- | ---- | --------------- |
| 1   | SIMPLE      | bookings | ref  | idx_bookings_property_id | idx_bookings_property_id | 16      | const | 50   | **Using where** |

**What I Noticed:**

- **`key: idx_bookings_property_id`**: The database was using the index on `property_id` to quickly find all bookings for that property. It estimated about 50 bookings (`rows: 50`).
- **`Extra: Using where`**: This was a red flag. After finding those 50 rows, the database had to read each one from the disk and manually check if `status = 'confirmed'`, `start_date <= '2024-01-31'`, and `end_date >= '2024-01-01'`. This felt inefficient, especially imagining a property with hundreds of bookings.

---

#### **What I Did AFTER Adding the Index**

To improve performance, I created a composite index called `idx_bookings_availability` and then re-ran the same `EXPLAIN` command.

**Command I Ran:**

```sql
CREATE INDEX idx_bookings_availability ON bookings(property_id, start_date, end_date);
EXPLAIN SELECT ... ;` (using the query above)
```

**What `EXPLAIN` Showed (Simplified):**

| id  | select_type | table    | type  | possible_keys                                      | key                           | key_len | ref  | rows  | Extra                        |
| --- | ----------- | -------- | ----- | -------------------------------------------------- | ----------------------------- | ------- | ---- | ----- | ---------------------------- |
| 1   | SIMPLE      | bookings | range | idx_bookings_availability,idx_bookings_property_id | **idx_bookings_availability** | 22      | NULL | **5** | **Using where; Using index** |

**What I Noticed:**

- **`key: idx_bookings_availability`**: The database switched to my new composite index, which was a good sign!
- **`type: range`**: This was exciting—it meant the database could use the index to directly find rows within the specified date range for the given `property_id`.
- **`rows: 5`**: The number of rows scanned dropped from 50 to just 5 (hypothetically). The database skipped irrelevant bookings, like those from 2023 or 2025, and went straight to the ones that mattered.
- **`Extra: Using index`**: This was a bonus. It showed that the database could pull some data directly from the index without reading the full rows, making things even faster.

**My Takeaway:**

By adding the composite index, I transformed the database’s approach from “find all bookings for this property and check each one” to “jump straight to the bookings for this property within the date range.” This cut down on disk I/O and CPU usage, making the query run much faster. I can see this being a game-changer as the `bookings` table grows.
