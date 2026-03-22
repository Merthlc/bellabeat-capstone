SELECT 
Count(*) as total_rows,
Countif(ID is null) as null_id,
Countif(Time is null) as null_Time,
Countif(Value is null) as null_Value
 FROM `capstone-project-475109.Fitabase_Data.hearthrate_seconds` 