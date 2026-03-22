WITH weight_tracker_users AS (
  SELECT DISTINCT Id
  FROM `capstone-project-475109.Fitabase_Data.v_weight_log_cleaned`
),
hourly_labeled AS (
  SELECT
    h.Id,
    CASE 
      WHEN w.Id IS NOT NULL THEN 'Weight Tracker'
      ELSE 'Non-Weight Tracker'
    END as user_type,
    CASE 
      WHEN EXTRACT(DAYOFWEEK FROM h.activity_time) IN (1,7)
        THEN 'Weekend'
      ELSE 'Weekday'
    END as day_type,
    EXTRACT(HOUR FROM h.activity_time) as hour_of_day,
    h.Calories
  FROM `capstone-project-475109.Fitabase_Data.v_Hourly_Calories_cleaned` as h
  LEFT JOIN weight_tracker_users w
    ON h.Id = w.Id
),
user_level_hourly AS (
  SELECT
    Id,
    user_type,
    day_type,
    hour_of_day,
    AVG(Calories) as avg_hourly_calories
  FROM hourly_labeled
  GROUP BY Id, user_type, day_type, hour_of_day
)

SELECT
  user_type,
  day_type,
  hour_of_day,
  ROUND(AVG(avg_hourly_calories), 1) as avg_calorie_spent
FROM user_level_hourly
GROUP BY user_type, day_type, hour_of_day
ORDER BY user_type, day_type, hour_of_day;
