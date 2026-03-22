CREATE OR REPLACE VIEW `capstone-project-475109.Fitabase_Data.v_hearthrate_seconds_cleaned` AS
SELECT 
    CAST(h.Id AS STRING) as Id,
    CAST(PARSE_DATETIME('%m/%d/%Y %I:%M:%S %p', h.Time) AS DATE) as activity_date,
    EXTRACT(HOUR FROM PARSE_DATETIME('%m/%d/%Y %I:%M:%S %p', h.Time)) as hour_of_day,
    PARSE_DATETIME('%m/%d/%Y %I:%M:%S %p', h.Time) as heartrate_time,
    h.Value as hearth_rate
FROM `capstone-project-475109.Fitabase_Data.hearthrate_seconds` h
INNER JOIN `capstone-project-475109.Fitabase_Data.v_daily_activity_cleaned` d 
    ON CAST(h.Id AS STRING) = d.Id 
    AND CAST(PARSE_DATETIME('%m/%d/%Y %I:%M:%S %p', h.Time) AS DATE) = d.activity_date;