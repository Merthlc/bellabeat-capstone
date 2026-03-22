SELECT 
Count(*) as total_rows,
Countif(ID is null) as null_id,
Countif(Activity_Minute is null) as null_Activity_Minute,
Countif(Intensity is null) as null_Intensity  
FROM `capstone-project-475109.Fitabase_Data.Minute_Intensities` 