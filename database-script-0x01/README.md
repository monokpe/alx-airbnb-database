# 🏠 Airbnb Clone – Database Schema

This SQL file defines the database schema for an Airbnb clone project. It models the core entities and relationships needed for a vacation rental platform.

## 🗂️ Schema Overview

The database consists of the following tables:

| Table        | Purpose                                  |
| ------------ | ---------------------------------------- |
| `users`      | Stores user info (guests, hosts, admins) |
| `properties` | Listings created by hosts                |
| `bookings`   | Records of property bookings             |
| `payments`   | Payment records linked to bookings       |
| `reviews`    | User reviews for properties              |
| `messages`   | Guest-host messaging system              |

## 🔑 Key Features

- **UUIDs** as primary keys for all tables
- **Timestamps** for audit (created/updated)
- **Role-based access** for users
- **Indexes** on foreign keys and frequently queried fields
- **Check constraints** to enforce valid values

## 📦 Relationships

- `users` ↔ `properties` (1:N)
- `users` ↔ `bookings` (1:N)
- `properties` ↔ `bookings` (1:N)
- `bookings` ↔ `payments` (1:1)
- `users` ↔ `reviews` ↔ `properties` (N:M)
- `users` ↔ `messages` (self-referencing messaging system)

## ⚙️ Usage

Run this schema in your PostgreSQL or MySQL-compatible environment before inserting any data.

```bash
psql -d your_db_name -f schema.sql
# or
mysql -u root -p your_db_name < schema.sql
```
