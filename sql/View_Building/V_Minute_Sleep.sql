CREATE OR REPLACE VIEW `capstone-project-475109.Fitabase_Data.v_Minute_Sleep_cleaned` AS
WITH unique_sleep AS (
    -- Removing Duplicated records
    SELECT DISTINCT 
        CAST(Id AS STRING) as Id,
        PARSE_DATETIME('%m/%d/%Y %I:%M:%S %p', Activity_Minute) as sleep_time,
        value as sleep_state,
        logId
    FROM `capstone-project-475109.Fitabase_Data.Minute_Sleep`
)
SELECT 
    s.Id,
    CAST(s.sleep_time AS DATE) as activity_date,
    EXTRACT(HOUR FROM s.sleep_time) as hour_of_day,
    s.sleep_time,
    s.sleep_state,
    s.logId
FROM unique_sleep s
INNER JOIN `capstone-project-475109.Fitabase_Data.v_daily_activity_cleaned` d 
    ON s.Id = d.Id 
    AND CAST(s.sleep_time AS DATE) = d.activity_date;