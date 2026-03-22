SELECT 
Count(*) total_row,
Countif(ID is Null) as null_id,
Countif(Time is Null) as null_time,
Countif(Calories is Null) as Calories,
 FROM `capstone-project-475109.Fitabase_Data.Hourly_Calories` LIMIT 1000