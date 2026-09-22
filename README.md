# Hotel Reservation Operations Analytics

## Project Overview
This project analyzes hotel reservation data using MySQL and SQL. It identifies booking trends, guest behavior, room demand, stay outcomes, staff workload, cancellations, and no-shows.

## Objective
The main objective of this project is to use SQL to transform hotel reservation data into meaningful business insights that support better hotel operations and decision-making.

## Tools Used
- MySQL
- SQL
- MySQL Workbench
- PowerPoint

## Dataset Tables
- `guests_mysql_ready.csv` – Guest information
- `hotels_mysql_ready.csv` – Hotel details
- `rooms.csv` – Room details and room types
- `bookings_mysql_ready.csv` – Booking information
- `stays.csv` – Guest stay records and outcomes
- `staff-1.csv` – Staff information

## Database Structure
The project uses six related tables: Guests, Hotels, Rooms, Bookings, Stays, and Staff.

Main relationships:
- One guest can make multiple bookings.
- Each booking belongs to a hotel.
- Each hotel has multiple rooms.
- Each booking can be connected to a stay.
- Each stay is assigned to a room and a staff member.

## Key Analysis Areas
- Booking trends by hotel, channel, and room type
- Repeat and high-value guest analysis
- Stay duration and stay outcomes
- Room utilization and staff workload
- Cancellation and no-show analysis

## Key Findings
- The website is the leading booking channel.
- Standard rooms are the most requested room type.
- StayPoint Kolkata Residency has the highest booking volume.
- Repeat and high-value guests can be targeted with retention offers.
- StayPoint Kochi Palace has the highest cancellation and no-show rate.

## Business Recommendations
- Strengthen the website booking channel.
- Plan room availability and pricing around high-demand hotels and room types.
- Provide loyalty offers for repeat and high-value guests.
- Investigate cancellation and no-show patterns.
- Improve staff allocation using service-request and workload data.

## Files in This Repository
- `hotel_analysis.sql` – SQL queries used for the analysis
- `Finally_ER_Diagram.mwb` – MySQL Workbench ER diagram
- CSV files – Dataset tables used in the project

## Author
Sanjana
