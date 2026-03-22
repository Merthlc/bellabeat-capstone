CREATE OR REPLACE VIEW `capstone-project-475109.Fitabase_Data.v_daily_activity_cleaned` AS

SELECT

    * -- (Tüm sütunlar)

FROM `capstone-project-475109.Fitabase_Data.Daily_activity`

WHERE TotalSteps > 1000

  AND Calories > 1000;