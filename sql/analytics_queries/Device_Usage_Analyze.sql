WITH weightloggerlar AS (
  -- Segmenting users
  SELECT DISTINCT CAST(Id AS STRING) as ID, "Weight-tracker" as segment 
  FROM `capstone-project-475109.Fitabase_Data.v_weight_log_cleaned`
),
global_benchmarks AS (
  -- Finding the last date of the entire dataset to measure churn
  SELECT MAX(ActivityDate) as max_data_date FROM `capstone-project-475109.Fitabase_Data.Daily_activity`
),
user_metrics AS (
  -- Calculating both loyalty (churn) and activity metrics per user
  SELECT 
    CAST(Id AS STRING) as ID,
    MIN(ActivityDate) as first_day,
    MAX(ActivityDate) as last_day,
    -- Loyalty: Days between their last record and the dataset's end
    DATE_DIFF((SELECT max_data_date FROM global_benchmarks), MAX(ActivityDate), DAY) as days_since_end,
    -- Total days in the system (Retention)
    DATE_DIFF(MAX(ActivityDate), MIN(ActivityDate), DAY) + 1 as total_days_in_system,
    -- Active usage days (Engagement criteria)
    COUNTIF(TotalSteps >= 2000 AND Calories >= 1200 AND SedentaryMinutes <= 1380) as active_days
  FROM `capstone-project-475109.Fitabase_Data.Daily_activity`
  GROUP BY 1
),
final_joined AS (
  -- Joining metrics with segments
  SELECT 
    CASE WHEN w.segment IS NOT NULL THEN 'Weight-Tracker' ELSE 'Non-Tracker' END as user_segment,
    u.days_since_end,
    u.total_days_in_system,
    u.active_days
  FROM user_metrics u
  LEFT JOIN weightloggerlar w ON u.ID = w.ID
)

-- Final Summary: Combining Loyalty and Usage Ratio
SELECT 
  user_segment,
  COUNT(*) as total_users,
  -- Loyalty Metric: Users who stayed until the last 3 days
  COUNTIF(days_since_end <= 3) as loyal_users,
  -- Engagement Metric: Average days they provided high-quality data
  ROUND(AVG(active_days), 1) as avg_active_days,
  -- The Ultimate Ratio: How much of their "owned" time was "active" time?
  ROUND(AVG(SAFE_DIVIDE(active_days, total_days_in_system)) * 100, 2) as usage_consistency_pct,
  -- Churn Metric: How many days early did they stop on average?
  ROUND(AVG(days_since_end), 1) as avg_days_dropped_early
FROM final_joined
GROUP BY 1;