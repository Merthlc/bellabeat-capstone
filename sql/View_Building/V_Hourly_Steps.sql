CREATE OR REPLACE VIEW `capstone-project-475109.Fitabase_Data.v_hourly_steps_cleaned` AS
SELECT 
    CAST(h.Id AS STRING) as Id, 
    CAST(PARSE_DATETIME('%m/%d/%Y %I:%M:%S %p', h.Activity_hour) AS DATE) as activity_date,
    EXTRACT(HOUR FROM PARSE_DATETIME('%m/%d/%Y %I:%M:%S %p', h.Activity_hour)) as hour_of_day,
    h.Steps
FROM `capstone-project-475109.Fitabase_Data.Hourly_steps` h
INNER JOIN `capstone-project-475109.Fitabase_Data.v_daily_activity_cleaned` d 
    ON CAST(h.Id AS STRING) = d.Id 
    AND CAST(PARSE_DATETIME('%m/%d/%Y %I:%M:%S %p', h.Activity_hour) AS DATE) = d.activity_date;