SQL Join Queries

This repository contains SQL queries demonstrating various types of joins (INNER JOIN, LEFT JOIN, and FULL OUTER JOIN equivalent) based on a hypothetical booking platform database schema.
Database Schema Overview

The SQL file assumes the following database schema:

    users: Stores user information (guests, hosts, admins).

    properties: Contains details about properties listed by hosts.

    bookings: Records bookings made by users for properties.

    payments: Stores payment information for bookings.

    reviews: Holds user reviews for properties.

    messages: Manages messages exchanged between users.

Queries Included

    INNER JOIN - Bookings and Users:

        Objective: To retrieve all bookings along with the details of the users who made them.

        Purpose: Shows how to combine rows from two tables where there is a match in a specified column.

    LEFT JOIN - Properties and Reviews:

        Objective: To retrieve all properties and their associated reviews, including properties that do not have any reviews yet.

        Purpose: Demonstrates how to return all rows from the left table (properties), and the matching rows from the right table (reviews). If there's no match, NULL values are returned for the right table's columns.

    FULL OUTER JOIN - Users and Bookings (MySQL Workaround):

        Objective: To retrieve all users and all bookings, regardless of whether a user has made a booking or a booking exists without a linked user (e.g., due to data inconsistencies).

        Purpose: Illustrates how to combine LEFT JOIN and RIGHT JOIN with UNION ALL to achieve the functionality of a FULL OUTER JOIN, which is useful for database systems like MySQL that do not natively support FULL OUTER JOIN. A direct FULL OUTER JOIN syntax is commented out for databases that do support it (e.g., PostgreSQL).

Usage

These queries can be executed against a database that has the specified schema. Ensure your database system is compatible with the SQL syntax (especially for FULL OUTER JOIN).
