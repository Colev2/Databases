-- ============================================================================
-- HotelBookingDB Views
-- ============================================================================
-- 5 views for operational and analytics purposes
-- ============================================================================

USE HotelBookingDB;

-- ============================================================================
-- View 1: vw_hotel_reservations
-- Purpose: Operational view combining reservation details, stay duration, 
--          hotel info, and guest contact
-- ============================================================================
DROP VIEW IF EXISTS vw_hotel_reservations;
CREATE VIEW vw_hotel_reservations AS
SELECT DISTINCT r.reservation_id AS "Reservation ID", h.hotel_id AS "Hotel ID", rrt.room_name AS "Room", rrt.quantity AS "Quantity", r.checkin_date AS "Check-in", r.checkout_date AS "Check-out", r.total_price AS "Price", r.num_guests AS "Guests", u.full_name AS "Guest Name", u.email AS "Guest Email"
FROM Reservation r
JOIN User u ON r.guest_id = u.user_id
JOIN ReservationRoomType rrt ON r.reservation_id = rrt.reservation_id
JOIN Hotel h ON rrt.hotel_id = h.hotel_id;

-- ============================================================================
-- View 2: vw_daily_room_occupancy
-- Purpose: Monitor daily occupancy per room type
-- Calculated: occupancy_rate = booked_rooms / total_rooms * 100
-- ============================================================================
DROP VIEW IF EXISTS vw_daily_room_occupancy;
CREATE VIEW vw_daily_room_occupancy AS
SELECT h.hotel_id AS "Hotel ID", i.date AS "Date", rt.room_name AS "Room Name", rt.total_rooms AS "Total", i.booked_rooms AS "Booked", ROUND((i.booked_rooms / rt.total_rooms) * 100, 2) AS "Occupancy (%)"
FROM RoomType rt
JOIN Inventory i ON rt.hotel_id = i.hotel_id AND rt.room_name = i.room_name
JOIN Hotel h ON rt.hotel_id = h.hotel_id;

-- ============================================================================
-- View 3: vw_reservation_payments_status
-- Purpose: Financial summary for each reservation
-- Calculated: total_paid = SUM(Payment.amount), balance_due = total_price - total_paid
-- ============================================================================
DROP VIEW IF EXISTS vw_reservation_payments_status;
CREATE VIEW vw_reservation_payments_status AS
SELECT r.reservation_id AS "Reservation ID", u.full_name AS "Guest Name", r.total_price AS "Total Price", COALESCE(SUM(p.amount), 0) AS "Paid", r.total_price - COALESCE(SUM(p.amount), 0) AS "Balance Due"
FROM Reservation r
INNER JOIN User u ON r.guest_id = u.user_id
LEFT JOIN Payment p ON r.reservation_id = p.reservation_id
GROUP BY r.reservation_id;

-- ============================================================================
-- View 4: vw_available_room_inventory
-- Purpose: Real-time list of bookable room inventory
-- Calculated: available_rooms = total_rooms - booked_rooms
-- Filter: Only rows where available_rooms > 0
-- ============================================================================
DROP VIEW IF EXISTS vw_available_room_inventory;
CREATE VIEW vw_available_room_inventory AS
SELECT h.hotel_id AS "Hotel ID", h.hotel_name AS "Hotel Name", h.city AS "City", h.star_rating AS "Stars", rt.room_name AS "Room Name", i.date AS "Date", i.base_price AS "Base Price", rt.max_occupancy AS "Max Guests", i.min_stay AS "Min Stay", (rt.total_rooms - i.booked_rooms) AS "Available Rooms"
FROM Hotel h
JOIN RoomType rt ON h.hotel_id = rt.hotel_id
JOIN Inventory i ON rt.hotel_id = i.hotel_id AND rt.room_name = i.room_name
WHERE (rt.total_rooms - i.booked_rooms) > 0;

-- ============================================================================
-- View 5: vw_guest_lifetime_value
-- Purpose: Measure guest loyalty and financial value
-- Calculated: total_reservations = COUNT, total_spent = SUM(payments)
-- ============================================================================
DROP VIEW IF EXISTS vw_guest_lifetime_value;
CREATE VIEW vw_guest_lifetime_value AS
SELECT g.user_id AS "Guest ID", u.full_name AS "Guest Name", g.nationality AS "Nationality", g.loyalty_level AS "Loyalty Level", COUNT(DISTINCT r.reservation_id) AS "Total Reservations", COALESCE(SUM(r.total_price), 0) AS "Lifetime Spent"
FROM Guest g
INNER JOIN User u ON g.user_id = u.user_id
LEFT JOIN Reservation r ON g.user_id = r.guest_id
GROUP BY g.user_id;

-- ============================================================================
-- End of Views
-- ============================================================================
