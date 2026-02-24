-- ============================================================================
-- Query 6: Theta Join (⋈_θ) + Rename (ρ)
-- Relational Algebra: ρ_R1(ReservationRoomType) ⋈_θ ρ_R2(ReservationRoomType)
--                     where θ: R1.reservation_id = R2.reservation_id 
--                              ∧ R1.room_name < R2.room_name
-- ============================================================================
-- Business Scenario:
--   The hotel management wants to identify reservations where guests have
--   booked multiple different room types (e.g., a family booking both
--   a "Deluxe Suite" and a "Standard Twin Room" in the same reservation).
-- 
-- Tables Used: ReservationRoomType (self-joined)
-- Operations:
--   - Rename (ρ): Creates two aliases (R1, R2) of the same table for self-join
--   - Theta Join: Joins R1 and R2 on matching reservation_id with inequality
--                 condition on room_name to find different room types
-- 
-- Technical Note:
--   Using "<" instead of "!=" avoids showing the same pair twice
--   (e.g., prevents both "Deluxe/Standard" and "Standard/Deluxe" from appearing)
-- ============================================================================

USE HotelBookingDB;

-- Find reservations with at least two different room types using self-join
-- DISTINCT ensures unique combinations are returned
SELECT DISTINCT R1.reservation_id AS "Reservation ID", R1.room_name AS "Room 1", R2.room_name AS "Room 2"
FROM ReservationRoomType R1
JOIN ReservationRoomType R2 ON R1.reservation_id = R2.reservation_id AND R1.room_name < R2.room_name;