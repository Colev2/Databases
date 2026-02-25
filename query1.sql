-- ============================================================================
-- Query 1: Selection (σ)
-- Relational Algebra: σ_city='Thessaloniki' ∧ star_rating≥4 (Hotel)
-- ============================================================================
-- Business Scenario:
--   A traveler is looking for luxury accommodation in Thessaloniki.
--   They want to see only high-end hotels (4+ stars) for a premium stay.
-- 
-- Tables Used: Hotel
-- Operation: Selection filters rows based on city and star rating conditions
-- ============================================================================

USE HotelBookingDB;

-- Retrieve luxury hotels (4+ stars) located in Thessaloniki
-- Ordered by star rating in descending order to show best hotels first
SELECT hotel_name AS "Hotel Name", description AS Description, star_rating AS Stars, street_address AS Address 
FROM Hotel
WHERE city = 'Thessaloniki' AND star_rating >= 4
ORDER BY star_rating DESC