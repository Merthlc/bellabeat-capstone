SELECT Count(*) as total_rows,
Countif(ID is null) as null_id,
Countif(Activity_Hour is null) as null_activity_hour,
Countif(Total_Intensity is null) as null_Total_Intensity,
Countif(Average_Intensity is null) as Average_Intensity
FROM `capstone-project-475109.Fitabase_Data.Hourly_intensities` LIMIT 1000