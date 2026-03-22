-- 1. Daily Activity (Id + ActivityDate)
SELECT 'Daily_Activity' as table_name, COUNT(*) as total, COUNT(DISTINCT CONCAT(TRIM(CAST(Id AS STRING)),"&", CAST(ActivityDate AS STRING))) as unique_after_trim
FROM `capstone-project-475109.Fitabase_Data.Daily_activity`
UNION ALL
-- 2. Hourly Calories (Id + Time)
SELECT 'Hourly_Calories', COUNT(*), COUNT(DISTINCT CONCAT(TRIM(CAST(Id AS STRING)),"&", TRIM(Time)))
FROM `capstone-project-475109.Fitabase_Data.Hourly_Calories`
UNION ALL
-- 3. Hourly Intensities (Id + Time)
SELECT 'Hourly_Intensities', COUNT(*), COUNT(DISTINCT CONCAT(TRIM(CAST(Id AS STRING)),"&", TRIM(Activity_Hour)))
FROM `capstone-project-475109.Fitabase_Data.Hourly_intensities`
UNION ALL
-- 4. Hourly Steps (Id + Time)
SELECT 'Hourly_Steps', COUNT(*), COUNT(DISTINCT CONCAT(TRIM(CAST(Id AS STRING)),"&", TRIM(Activity_Hour)))
FROM `capstone-project-475109.Fitabase_Data.Hourly_steps`
UNION ALL
-- 5. Minute Sleep (Id + Activity_Minute)
SELECT 'Minute_Sleep', COUNT(*), COUNT(DISTINCT CONCAT(TRIM(CAST(Id AS STRING)),"&", TRIM(Activity_Minute)))
FROM `capstone-project-475109.Fitabase_Data.Minute_Sleep`
UNION ALL
-- 6. Weight Log Info (Id + Date)
SELECT 'Weight_Log', COUNT(*), COUNT(DISTINCT CONCAT(TRIM(CAST(Id AS STRING)),"&", TRIM(Date)))
FROM `capstone-project-475109.Fitabase_Data.Weight_log_info`
UNION ALL
-- 7. Heartrate Seconds (Id + Time) - Çok satır olabilir, dikkat!
SELECT 'Heartrate_Seconds', COUNT(*), COUNT(DISTINCT CONCAT(TRIM(CAST(Id AS STRING)),"&", TRIM(Time)))
FROM `capstone-project-475109.Fitabase_Data.hearthrate_seconds`
UNION ALL
-- 8. Minute METs (Id + ActivityMinute)
SELECT 'Minute_METs', COUNT(*), COUNT(DISTINCT CONCAT(TRIM(CAST(Id AS STRING)),"&", TRIM(Activity_minute)))
FROM `capstone-project-475109.Fitabase_Data.Minute_MET`
UNION ALL
-- 9. Minute Calories (Id + ActivityMinute)
SELECT 'Minute_Calories', COUNT(*), COUNT(DISTINCT CONCAT(TRIM(CAST(Id AS STRING)),"&", TRIM(Activity_minute)))
FROM `capstone-project-475109.Fitabase_Data.Minute_Calories`
UNION ALL
-- 10. Minute Intensities (Id + ActivityMinute)
SELECT 'Minute_Intensities', COUNT(*), COUNT(DISTINCT CONCAT(TRIM(CAST(Id AS STRING)),"&", TRIM(Activity_minute)))
FROM `capstone-project-475109.Fitabase_Data.Minute_Intensities`
UNION ALL
-- 11. Minute Steps (Id + ActivityMinute)
SELECT 'Minute_Steps', COUNT(*), COUNT(DISTINCT CONCAT(TRIM(CAST(Id AS STRING)),"&", TRIM(Activity_minute)))
FROM `capstone-project-475109.Fitabase_Data.Minute_steps`;