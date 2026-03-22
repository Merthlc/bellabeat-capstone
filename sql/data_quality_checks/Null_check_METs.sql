SELECT 
Count(*) as total_rows,
Countif(ID is null) as null_id,
Countif(Activity_Minute is null) as null_Activity_Minute,
Countif(METs is null) as null_METs
 FROM `capstone-project-475109.Fitabase_Data.Minute_MET` 