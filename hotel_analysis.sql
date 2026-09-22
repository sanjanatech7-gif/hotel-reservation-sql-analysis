
-- HOTEL RESERVATION OPERATIONS ANALYTICS
-- Database Setup - Sprint 2.1
-- --------------------------------------------------
-- 1. CREATE DATABASE

CREATE DATABASE Hotel_Reservation_DB;


USE Hotel_Reservation_DB;


-- 2. GUESTS TABLE

CREATE TABLE Guests
(
    guest_id VARCHAR(20) PRIMARY KEY,
    guest_name VARCHAR(100),
    city VARCHAR(50),
    guest_type VARCHAR(20),
    preferred_room_type VARCHAR(20),
    loyalty_tier VARCHAR(20),
    account_since DATE
);



-- 3. HOTELS TABLE

CREATE TABLE Hotels
(
    hotel_id VARCHAR(20) PRIMARY KEY,
    hotel_name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    star_rating INT,
    total_rooms INT,
    opened_date DATE
);



-- 4. ROOMS TABLE

CREATE TABLE Rooms
(
    room_id VARCHAR(20) PRIMARY KEY,
    hotel_id VARCHAR(20) NOT NULL,
    room_type VARCHAR(20),
    floor_number INT,
    max_occupancy INT,
    price_per_night DECIMAL(10,2),
    is_active VARCHAR(3),

    CONSTRAINT FK_Room_Hotel
        FOREIGN KEY (hotel_id)
        REFERENCES Hotels(hotel_id)
);



-- 5. STAFF TABLE


CREATE TABLE Staff
(
    staff_id VARCHAR(20) PRIMARY KEY,
    staff_name VARCHAR(100) NOT NULL,
    hire_date DATE,
    rating DECIMAL(3,2),
    department VARCHAR(30),
    is_active VARCHAR(3)
);



-- 6. BOOKINGS TABLE


CREATE TABLE Bookings
(
    booking_id VARCHAR(20) PRIMARY KEY,
    guest_id VARCHAR(20) NOT NULL,
    hotel_id VARCHAR(20) NOT NULL,
    booking_date DATE,
    room_type_requested VARCHAR(20),
    booking_channel VARCHAR(30),
    nights_booked INT,
    total_amount DECIMAL(12,2),

    CONSTRAINT FK_Booking_Guest
        FOREIGN KEY (guest_id)
        REFERENCES Guests(guest_id),

    CONSTRAINT FK_Booking_Hotel
        FOREIGN KEY (hotel_id)
        REFERENCES Hotels(hotel_id)
);



-- 7. STAYS TABLE


CREATE TABLE Stays
(
    stay_id VARCHAR(20) PRIMARY KEY,
    booking_id VARCHAR(20) NOT NULL,
    room_id VARCHAR(20) NOT NULL,
    staff_id VARCHAR(20),
    check_in_date DATE,
    check_out_date DATE,
    status VARCHAR(20),
    nights_stayed INT,
    service_requests INT,
    stay_duration_hrs INT,

    CONSTRAINT FK_Stay_Booking
        FOREIGN KEY (booking_id)
        REFERENCES Bookings(booking_id),

    CONSTRAINT FK_Stay_Room
        FOREIGN KEY (room_id)
        REFERENCES Rooms(room_id),

    CONSTRAINT FK_Stay_Staff
        FOREIGN KEY (staff_id)
        REFERENCES Staff(staff_id)
);


-- 8. VERIFY TABLES


SHOW TABLES;

-- 9. CHECK TABLE STRUCTURES


DESCRIBE Guests;
SELECT * FROM Guests;
SELECT COUNT(*) FROM Guests;

DESCRIBE Hotels;
SELECT * FROM Hotels;

DESCRIBE Rooms;
SELECT * FROM Rooms;

DESCRIBE Staff;
SELECT * FROM Staff;

DESCRIBE Bookings;
SELECT * FROM Bookings;

DESCRIBE Stays;
SELECT * FROM Stays;


-- HOTEL RESERVATION OPERATIONS ANALYTICS

-- SPRINT 3 - BASIC ANALYSIS / DATA EXPLORATION
-- -------------------------------------------------------

USE Hotel_Reservation_DB;


-- 1. TOTAL NUMBER OF GUESTS

SELECT COUNT(*) AS total_guests
FROM Guests;



-- 2. TOTAL NUMBER OF BOOKINGS

SELECT COUNT(*) AS total_bookings
FROM Bookings;


-- 3. TOTAL NUMBER OF STAYS

SELECT COUNT(*) AS total_stays
FROM Stays;


-- 4. DIFFERENT ROOM TYPES AVAILABLE

SELECT DISTINCT room_type
FROM Rooms;



-- 5. NUMBER OF ACTIVE STAFF MEMBERS

SELECT COUNT(*) AS active_staff
FROM Staff
WHERE is_active = 'Yes';



-- 6. DIFFERENT BOOKING CHANNELS

SELECT DISTINCT booking_channel
FROM Bookings;



-- 7. TOTAL BOOKING AMOUNT

SELECT SUM(total_amount) AS total_booking_amount
FROM Bookings;


-- 8. AVERAGE NIGHTS BOOKED PER BOOKING


SELECT ROUND(AVG(nights_booked), 2) AS average_nights_booked
FROM Bookings;

-- HOTEL RESERVATION OPERATIONS ANALYTICS

-- SPRINT 4 - OBJECTIVE BASED ANALYSIS
-- ------------------------------------------------------------

USE Hotel_Reservation_DB;



-- 4.1 UNDERSTAND BOOKING DEMAND



-- Q1. How many bookings are made at each hotel?

SELECT 
    h.hotel_name,
    COUNT(b.booking_id) AS total_bookings
FROM Hotels  as h
LEFT JOIN Bookings  as b
    ON h.hotel_id = b.hotel_id
GROUP BY h.hotel_id, h.hotel_name
ORDER BY total_bookings DESC;



-- Q2. How many bookings are made through each booking channel?


SELECT 
    booking_channel,
    COUNT(*) AS total_bookings
FROM Bookings
GROUP BY booking_channel
ORDER BY total_bookings DESC;


-- Q3. How many bookings are made for each requested room type?

  


-- Q4. How does booking volume change over time?


SELECT 
    YEAR(booking_date) AS booking_year,
    MONTH(booking_date) AS booking_month,
    COUNT(*) AS total_bookings
FROM Bookings
GROUP BY booking_year, booking_month
ORDER BY booking_year, booking_month;


-- Q5. What is the total booking amount for each hotel?

SELECT 
    h.hotel_name,
    SUM(b.total_amount) AS total_booking_amount
FROM Hotels h
JOIN Bookings b
    ON h.hotel_id = b.hotel_id
GROUP BY h.hotel_id, h.hotel_name
ORDER BY total_booking_amount DESC;

-- Q6. What is the average booking amount for each booking channel?

SELECT 
    booking_channel,
    ROUND(AVG(total_amount), 2) AS average_booking_amount
FROM Bookings
GROUP BY booking_channel
ORDER BY average_booking_amount DESC;




-- 4.2 UNDERSTAND GUEST BOOKING BEHAVIOUR


-- Q1. How many bookings has each guest made?

SELECT 
    g.guest_id,
    g.guest_name,
    COUNT(b.booking_id) AS total_bookings
FROM Guests as g
LEFT JOIN Bookings b
    ON g.guest_id = b.guest_id
GROUP BY g.guest_id, g.guest_name
ORDER BY total_bookings DESC;


-- Q2. Which guests have made multiple bookings?

SELECT 
    g.guest_id,
    g.guest_name,
    COUNT(b.booking_id) AS total_bookings
FROM Guests g
JOIN Bookings b
    ON g.guest_id = b.guest_id
GROUP BY g.guest_id, g.guest_name
HAVING COUNT(b.booking_id) > 1
ORDER BY total_bookings DESC;


-- Q3. Which guests have the highest total booking amount?

SELECT 
    g.guest_id,
    g.guest_name,
    SUM(b.total_amount) AS total_booking_amount
FROM Guests g
JOIN Bookings b
    ON g.guest_id = b.guest_id
GROUP BY g.guest_id, g.guest_name
ORDER BY total_booking_amount DESC
LIMIT 10;


-- Q4. How many bookings are made by Individual and Corporate guests?

SELECT 
    g.guest_type,
    COUNT(b.booking_id) AS total_bookings
FROM Guests g
JOIN Bookings b
    ON g.guest_id = b.guest_id
GROUP BY g.guest_type
ORDER BY total_bookings DESC;


-- Q5. What is the total booking amount for Individual and Corporate guests?

SELECT 
    g.guest_type,
    SUM(b.total_amount) AS total_booking_amount
FROM Guests g
JOIN Bookings b
    ON g.guest_id = b.guest_id
GROUP BY g.guest_type
ORDER BY total_booking_amount DESC;


-- Q6. Which hotels have the highest guest booking activity?

SELECT 
    h.hotel_name,
    COUNT(b.booking_id) AS total_bookings,
    COUNT(DISTINCT b.guest_id) AS unique_guests
FROM Hotels h
JOIN Bookings b
    ON h.hotel_id = b.hotel_id
GROUP BY h.hotel_id, h.hotel_name
ORDER BY total_bookings DESC;


-- Q7. How does guest booking activity change by year?

SELECT 
    YEAR(b.booking_date) AS booking_year,
    COUNT(b.booking_id) AS total_bookings,
    COUNT(DISTINCT b.guest_id) AS unique_guests
FROM Bookings b
GROUP BY YEAR(b.booking_date)
ORDER BY booking_year;
SELECT 
    st.staff_id,
    st.staff_name,
    st.rating,
    COUNT(s.stay_id) AS total_stays_handled
FROM Staff st
LEFT JOIN Stays s
    ON st.staff_id = s.staff_id
GROUP BY st.staff_id, st.staff_name, st.rating
ORDER BY total_stays_handled DESC;



-- 4.5 IDENTIFY BOOKING AND STAY PROBLEMS





-- Q1. How many bookings resulted in each stay status?


SELECT 
    s.status,
    COUNT(s.stay_id) AS total_stays
FROM Bookings b
JOIN Stays s
    ON b.booking_id = s.booking_id
GROUP BY s.status
ORDER BY total_stays DESC;



-- Q2. Which bookings resulted in cancellations?


SELECT 
    b.booking_id,
    b.guest_id,
    b.hotel_id,
    b.booking_date,
    b.booking_channel,
    b.total_amount,
    s.status
FROM Bookings b
JOIN Stays s
    ON b.booking_id = s.booking_id
WHERE s.status = 'Cancelled'
ORDER BY b.booking_date;




-- Q3. Which bookings resulted in no-shows?


SELECT 
    b.booking_id,
    b.guest_id,
    b.hotel_id,
    b.booking_date,
    b.booking_channel,
    b.total_amount,
    s.status
FROM Bookings b
JOIN Stays s
    ON b.booking_id = s.booking_id
WHERE s.status = 'No-show'
ORDER BY b.booking_date;


-- Q4. What is the average number of service requests by stay status?

SELECT 
    status,
    ROUND(AVG(service_requests), 2) AS average_service_requests
FROM Stays
GROUP BY status
ORDER BY average_service_requests DESC;


-- Q5. Which stays have a high number of service requests?

SELECT 
    stay_id,
    booking_id,
    room_id,
    staff_id,
    status,
    service_requests
FROM Stays
WHERE service_requests >=
(
    SELECT AVG(service_requests)
    FROM Stays
)
ORDER BY service_requests DESC;


 




