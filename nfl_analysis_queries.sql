/*
Project: NFL Concussion Recovery Analysis
Created By: Doel Nkalo
Description: Analysis of correlation between player positions, helmet brands, and recovery time.
*/

-- 1. Setup: Inspecting the Raw Data
-- Checking the players list to ensure position data is clean
SELECT * FROM nfl_players LIMIT 10;

-- Checking the injury log
SELECT * FROM concussion_log LIMIT 10;

-- 2. The Master Dataset
-- Joining tables to connect Players with their Injury History and Equipment
SELECT 
    p.player_name,
    p.position,
    p.team,
    c.helmet_brand,
    c.weeks_out
FROM nfl_players p
JOIN concussion_log c ON p.player_id = c.player_id;

-- 3. ANALYSIS: Average Recovery Time by Position
-- Finding: Running Backs (RB) have the highest average recovery time (3.0 weeks)
SELECT 
    p.position,
    COUNT(p.player_id) as total_injuries,
    AVG(c.weeks_out) as avg_recovery_weeks
FROM nfl_players p
JOIN concussion_log c ON p.player_id = c.player_id
GROUP BY p.position
ORDER BY avg_recovery_weeks DESC;

-- 4. ANALYSIS: Equipment Safety Audit
-- Finding: Comparing Helmet Brands to see if any are associated with longer recovery
SELECT 
    c.helmet_brand,
    COUNT(c.incident_id) as injury_count,
    AVG(c.weeks_out) as avg_recovery_weeks
FROM concussion_log c
GROUP BY c.helmet_brand
HAVING COUNT(c.incident_id) > 1 -- Filtering for brands with multiple data points
ORDER BY avg_recovery_weeks DESC;
