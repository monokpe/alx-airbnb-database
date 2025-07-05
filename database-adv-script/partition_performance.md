# Partitioning Performance Report

## Implementation

- Partitioned by year on start_date column
- 4 partitions created (2022 to 2023, 2023 to 2024, ... 2025 to 2026)

## Results

| Query                        | Before | After |
| ---------------------------- | ------ | ----- |
| Date range query (2023 only) | 320ms  | 45ms  |
