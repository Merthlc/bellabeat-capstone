CREATE OR REPLACE VIEW `capstone-project-475109.Fitabase_Data.v_hourly_intensities_cleaned` AS
WITH daily_log_counts AS (
    SELECT 
        Id,
        CAST(PARSE_DATETIME('%m/%d/%Y %I:%M:%S %p', Activity_Hour) AS DATE) as activity_date,
        COUNT(Activity_Hour) as hour_count
    FROM `capstone-project-475109.Fitabase_Data.Hourly_intensities`
    GROUP BY 1, 2
    HAVING hour_count = 24 
)
SELECT 
    CAST(h.Id AS STRING) as Id, 
    c.activity_date,
    EXTRACT(HOUR FROM PARSE_DATETIME('%m/%d/%Y %I:%M:%S %p', h.Activity_Hour)) as hour_of_day,
    h.Total_Intensity,
    h.Average_Intensity 
FROM `capstone-project-475109.Fitabase_Data.Hourly_intensities` h
INNER JOIN daily_log_counts c 
    ON h.Id = c.Id 
    AND CAST(PARSE_DATETIME('%m/%d/%Y %I:%M:%S %p', h.Activity_Hour) AS DATE) = c.activity_date
INNER JOIN `capstone-project-475109.Fitabase_Data.v_daily_activity_cleaned` d 
    ON CAST(h.Id AS STRING) = d.Id 
    AND c.activity_date = d.activity_date;