CREATE OR REPLACE VIEW `capstone-project-475109.Fitabase_Data.v_hourly_calories_cleaned` AS
WITH daily_log_counts AS (
    SELECT 
        Id,
        CAST(PARSE_DATETIME('%m/%d/%Y %I:%M:%S %p', Time) AS DATE) as activity_date,
        COUNT(Time) as hour_count
    FROM `capstone-project-475109.Fitabase_Data.Hourly_Calories`
    GROUP BY 1, 2
    HAVING hour_count = 24 -- only days consists of 24 hours of a day record
)
SELECT 
    TRIM(CAST(h.Id AS STRING)) as Id, --converting to string
    c.activity_date,
    EXTRACT(HOUR FROM PARSE_DATETIME('%m/%d/%Y %I:%M:%S %p', h.Time)) as hour_of_day,
    h.Calories
FROM `capstone-project-475109.Fitabase_Data.Hourly_Calories` h
INNER JOIN daily_log_counts c 
    ON h.Id = c.Id 
    AND CAST(PARSE_DATETIME('%m/%d/%Y %I:%M:%S %p', h.Time) AS DATE) = c.activity_date
INNER JOIN `capstone-project-475109.Fitabase_Data.v_daily_activity_cleaned` d 
    ON TRIM(CAST(h.Id AS STRING)) = d.Id 
    AND c.activity_date = d.activity_date;