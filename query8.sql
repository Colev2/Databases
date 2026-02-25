-- ============================================================================
-- Query 8: Left Outer Join (⟕)
-- Relational Algebra: RoomType ⟕_hotel_id,room_name RoomTypeAmenity 
--                              ⟕_amenity_id Amenity
-- ============================================================================
-- Business Scenario:
--   Hotel management needs a complete inventory of all room types and their
--   amenities. This includes room types that might not have any amenities
--   assigned yet (newly created room types or basic economy rooms).
-- 
-- Tables Used: RoomType, RoomTypeAmenity, Amenity
-- Operation: Left Outer Join preserves all rows from the left table (RoomType)
--            and includes matching rows from the right tables. Where no match
--            exists, NULL values are returned for the right table columns.
-- 
-- Join Chain:
--   1. RoomType LEFT JOIN RoomTypeAmenity → keeps all room types
--   2. Result LEFT JOIN Amenity → gets amenity details, keeps unmatched rooms
-- 
-- Note: Rows with no amenities will show NULL for Amenity, Category, and 
--       Amenity Description columns. This helps identify room types that
--       need amenity assignments.
-- ============================================================================

USE HotelBookingDB;

-- Retrieve all room types with their amenities (if any)
-- LEFT OUTER JOIN ensures room types without amenities are still included
SELECT rt.hotel_id as "Hotel ID", rt.room_name as "Room Type", a.amenity_name as Amenity, a.amenity_category as Category, rta.description as "Amenity Description"
FROM RoomType rt
LEFT OUTER JOIN RoomTypeAmenity rta ON rt.hotel_id = rta.hotel_id AND rt.room_name = rta.room_name
LEFT OUTER JOIN Amenity a ON rta.amenity_id = a.amenity_id
ORDER BY rt.hotel_id, rt.room_name, a.amenity_name;

