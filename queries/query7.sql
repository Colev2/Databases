-- ============================================================================
-- Query 7: Semijoin (⋉)
-- Relational Algebra: Hotel ⋉_hotel_id ReservationRoomType
-- ============================================================================
-- Business Scenario:
--   The hotel chain wants to identify which hotels have received at least
--   one booking. This helps distinguish active properties from those that
--   may need marketing attention or might be newly listed.
-- 
-- Tables Used: Hotel, ReservationRoomType
-- Operation: Semijoin returns rows from the left table (Hotel) that have
--            at least one matching row in the right table (ReservationRoomType)
-- 
-- Implementation:
--   - Uses EXISTS subquery to check for matching reservations
--   - EXISTS returns TRUE as soon as it finds one match (efficient)
--   - SELECT 1 is conventional - the actual value doesn't matter, only existence
-- ============================================================================

USE HotelBookingDB;

-- Find all hotels that have at least one reservation (active hotels)
-- EXISTS is preferred for semijoin as it stops scanning after first match
SELECT DISTINCT hotel_id AS "Hotel ID", hotel_name AS "Hotel Name", city AS City
FROM Hotel
WHERE EXISTS (
    SELECT 1  -- The value doesn't matter; only row existence is checked
    FROM ReservationRoomType 
    WHERE ReservationRoomType.hotel_id = Hotel.hotel_id
)
ORDER BY hotel_name;
