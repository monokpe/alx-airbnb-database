Here’s a brief and clear `README.md` you can include for the sample data in your Airbnb clone project:

---

````markdown
# 🏡 Airbnb Clone – Sample SQL Data

This file contains sample SQL insert statements for populating the core tables of an Airbnb-style rental platform. It is part of a full-stack clone project.

## 📦 Tables Covered

- **User** – Guests, hosts, and admins with roles and contact info.
- **Property** – Listings created by hosts with details like location and price.
- **Booking** – Booking records with dates, status, and total price.
- **Payment** – Payments linked to bookings, with method and amount.
- **Review** – User reviews with rating and comments.
- **Message** – Messages exchanged between guests and hosts.

## ✅ Usage

Run this script after creating the corresponding tables to seed your development or test database with sample data.

```sql
psql -d your_database_name -f seed.sql
```
````

> Replace `your_database_name` with the actual database name.

## 📌 Notes

- Passwords are hashed (placeholders).
- UUIDs are used for primary keys.
- Designed to reflect real-world usage and edge cases (e.g., canceled bookings, missing phone number).

---

Built with 💻 by James Onokpe
