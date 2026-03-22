SELECT  
Count(*) as total_rows,
Countif(ID is null) as null_id,
Countif(Date is null) as null_Date,
Countif(Weight_kg is null) as null_Weight_kg,
Countif(Weight_pounds is null) as Weight_pounds,
Countif(fat is null) as null_fat,
Countif(BMI is null) as null_BMI,
Countif(is_manual_report is null) as null_is_manual_report,
Countif(LogId is null) as null_LogId,
FROM `capstone-project-475109.Fitabase_Data.Weight_log_info` 