SELECT
  COUNT(*) AS total_rows,
  COUNTIF(id IS NULL) AS null_id,
  COUNTIF(ActivityDate IS NULL) AS null_activity_date,
  COUNTIF(TotalSteps IS NULL) AS null_total_steps,
  COUNTIF(TotalDistance IS NULL) AS null_total_distance,
  COUNTIF(TrackerDistance IS NULL) AS null_tracker_distance,
  COUNTIF(LoggedActivitiesDistance IS NULL) AS null_logged_activities_distance,
  COUNTIF(VeryActiveDistance IS NULL) AS null_very_active_distance,
  COUNTIF(ModeratelyActiveDistance IS NULL) AS null_moderately_active_distance,
  COUNTIF(LightActiveDistance IS NULL) AS null_light_active_distance,
  COUNTIF(SedentaryActiveDistance IS NULL) AS null_sedentary_active_distance,
  COUNTIF(VeryActiveMinutes IS NULL) AS null_very_active_minutes,
  COUNTIF(FairlyActiveMinutes IS NULL) AS null_fairly_active_minutes,
  COUNTIF(LightlyActiveMinutes IS NULL) AS null_lightly_active_minutes,
  COUNTIF(SedentaryMinutes IS NULL) AS null_sedentary_minutes,
  COUNTIF(Calories IS NULL) AS null_calories
FROM `capstone-project-475109.Fitabase_Data.Daily_activity`