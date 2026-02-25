-- ============================================================================
-- Query 4: Natural Join (⋈)
-- Relational Algebra: π_amenity_name,amenity_category,description(
--                       σ_hotel_id=1 ∧ room_name='Deluxe Suite'(
--                         RoomTypeAmenity ⋈_amenity_id Amenity))
-- ============================================================================
-- Business Scenario:
--   A guest wants to know all amenities available in the "Deluxe Suite"
--   room type at a specific hotel (hotel_id = 1). This helps them understand
--   the facilities and services included with their room booking.
-- 
-- Tables Used: RoomTypeAmenity, Amenity
-- Operation: Natural Join connects room type amenities with amenity details
--            using the common attribute 'amenity_id'
-- ============================================================================

USE HotelBookingDB;

-- Retrieve all amenities for "Deluxe Suite" in hotel_id = 1
-- Join RoomTypeAmenity with Amenity to get amenity details
SELECT amenity_name AS Amenity, amenity_category AS Category, description AS "Amenity Description"
FROM RoomTypeAmenity
JOIN Amenity ON RoomTypeAmenity.amenity_id = Amenity.amenity_id
WHERE hotel_id = 1 AND room_name = 'Deluxe Suite'
ORDER BY amenity_category, amenity_name;
