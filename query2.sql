-- ============================================================================
-- Query 2: Projection (π) + Union (∪)
-- Relational Algebra: π_hotel_name,city,star_rating(σ_city='Chania'(Hotel)) 
--                     ∪ π_hotel_name,city,star_rating(σ_city='Rethymno'(Hotel))
-- ============================================================================
-- Business Scenario:
--   A tourist planning a trip to Crete wants to explore accommodation options
--   in both Chania and Rethymno. This query combines hotels from both cities
--   into a single result set for easy comparison.
-- 
-- Tables Used: Hotel
-- Operations:
--   - Projection: Selects specific columns (hotel_name, city, star_rating)
--   - Union: Combines results from two SELECT statements, removing duplicates
-- ============================================================================

USE HotelBookingDB;

-- First set: Hotels located in Chania
SELECT hotel_name AS "Hotel Name", city AS City, star_rating AS Stars
FROM Hotel
WHERE city = 'Chania'

UNION

-- Second set: Hotels located in Rethymno
SELECT hotel_name AS Hotel, city AS City, star_rating AS Stars
FROM Hotel
WHERE city = 'Rethymno'

-- ORDER BY applies to the entire UNION result
ORDER BY city;
