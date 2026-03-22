SELECT 
Count(*) as total_rows,
Countif(ID is null) as null_id,
Countif(Activity_Hour is null) as null_activity_hour,
Countif(Steps is null) as null_Steps
FROM `capstone-project-475109.Fitabase_Data.Hourly_steps` LIMIT 1000