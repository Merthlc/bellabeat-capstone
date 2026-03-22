CREATE OR REPLACE VIEW `capstone-project-475109.Fitabase_Data.v_Minute_steps_cleaned` AS
SELECT 
    CAST(h.Id AS STRING) as Id, 
    CAST(PARSE_DATETIME('%m/%d/%Y %I:%M:%S %p', h.Activity_Minute) AS DATE) as activity_date,
    EXTRACT(HOUR FROM PARSE_DATETIME('%m/%d/%Y %I:%M:%S %p', h.Activity_Minute)) as hour_of_day,
    h.Steps
FROM `capstone-project-475109.Fitabase_Data.Minute_steps` h
INNER JOIN `capstone-project-475109.Fitabase_Data.v_daily_activity_cleaned` d 
    ON CAST(h.Id AS STRING) = d.Id 
    AND CAST(PARSE_DATETIME('%m/%d/%Y %I:%M:%S %p', h.Activity_Minute) AS DATE) = d.activity_date;