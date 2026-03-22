WITH Weightloggers as (
SELECT DISTINCT ID,
CASE WHEN ID IN (SELECT ID FROM `capstone-project-475109.Fitabase_Data.v_weight_log_cleaned` ) THEN 'Weight_Tracker' ELSE 'Non_Tracker' END as user_segment
FROM `capstone-project-475109.Fitabase_Data.Daily_activity`
)


SELECT w.user_segment,
 ROUND(AVG(a.TotalSteps),0) as Avg_Steps,
 ROUND(AVG(VeryActiveMinutes),0) as Avg_VeryActiveMinutes,
 ROUND(AVG(FairlyActiveMinutes),0) as Avg_FairlyActiveMinutes,
 ROUND(AVG(LightlyActiveMinutes),0) as Avg_LightlyActiveMinutes,
 ROUND(AVG(SedentaryMinutes),0) as Avg_SedentaryMinutes,
 ROUND(AVG(Calories),0) as Avg_Calories
FROM `capstone-project-475109.Fitabase_Data.Daily_activity` a
INNER JOIN Weightloggers w on w.ID = a.ID
WHERE a.TotalSteps > 0
GROUP BY w.user_segment