-- Create the partitioned parent table
CREATE TABLE bookings_partitioned (
    booking_id UUID PRIMARY KEY,
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status VARCHAR(10) CHECK (status IN ('pending', 'confirmed', 'canceled')) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    -- Enforce uniqueness across partitions
    UNIQUE (booking_id, start_date)
) PARTITION BY RANGE (start_date);

SELECT 'Created bookings_partitioned table' AS status;

-- Create yearly partitions with clear bounds
CREATE TABLE bookings_y2022 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2022-01-01') TO ('2023-01-01');
COMMENT ON TABLE bookings_y2022 IS 'Partition for bookings starting in 2022';

CREATE TABLE bookings_y2023 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');
COMMENT ON TABLE bookings_y2023 IS 'Partition for bookings starting in 2023';

CREATE TABLE bookings_y2024 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');
COMMENT ON TABLE bookings_y2024 IS 'Partition for bookings starting in 2024';

CREATE TABLE bookings_y2025 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');
COMMENT ON TABLE bookings_y2025 IS 'Partition for bookings starting in 2025';

-- Default partition to catch unexpected data
CREATE TABLE bookings_default PARTITION OF bookings_partitioned DEFAULT;
COMMENT ON TABLE bookings_default IS 'Default partition for unmatched start_date values';

SELECT 'Created partitions for 2022-2025 and a default partition' AS status;

-- Optional: Create indexes on commonly queried columns (per partition)
CREATE INDEX idx_property_id_2022 ON bookings_y2022 (property_id);
CREATE INDEX idx_user_id_2022 ON bookings_y2022 (user_id);
CREATE INDEX idx_status_2022 ON bookings_y2022 (status);

CREATE INDEX idx_property_id_2023 ON bookings_y2023 (property_id);
CREATE INDEX idx_user_id_2023 ON bookings_y2023 (user_id);
CREATE INDEX idx_status_2023 ON bookings_y2023 (status);

CREATE INDEX idx_property_id_2024 ON bookings_y2024 (property_id);
CREATE INDEX idx_user_id_2024 ON bookings_y2024 (user_id);
CREATE INDEX idx_status_2024 ON bookings_y2024 (status);

CREATE INDEX idx_property_id_2025 ON bookings_y2025 (property_id);
CREATE INDEX idx_user_id_2025 ON bookings_y2025 (user_id);
CREATE INDEX idx_status_2025 ON bookings_y2025 (status);
