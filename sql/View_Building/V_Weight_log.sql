CREATE OR REPLACE VIEW `capstone-project-475109.Fitabase_Data.v_weight_log_cleaned` AS
SELECT 
    CAST(Id AS STRING) as Id,
    CAST(PARSE_DATETIME('%m/%d/%Y %I:%M:%S %p', Date) AS DATE) as activity_date,
    Weight_kg,
    Weight_pounds,
    fat,
    BMI,
    is_manual_report,
    LogId
FROM `capstone-project-475109.Fitabase_Data.Weight_log_info`
-- Kilo verisini de ana aktivite filtremizle mühürlüyoruz
WHERE CAST(Id AS STRING) IN (SELECT DISTINCT Id FROM `capstone-project-475109.Fitabase_Data.v_daily_activity_cleaned`);