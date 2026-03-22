WITH weight_tracker_users AS (
  SELECT DISTINCT Id
  FROM `capstone-project-475109.Fitabase_Data.v_weight_log_cleaned`
),
daily_activity_labeled AS (
  SELECT 
    a.Id,
    a.TotalSteps,
    a.VeryActiveMinutes,
    a.SedentaryMinutes,
    CASE 
      WHEN w.Id IS NOT NULL THEN 'Weight Tracker'
      ELSE 'Non-Weight Tracker'
    END as user_type,
    CASE 
      WHEN EXTRACT(DAYOFWEEK FROM a.ActivityDate) IN (1,7)
        THEN 'Hafta Sonu'
      ELSE 'Hafta İçi'
    END as gun_segmenti
  FROM `capstone-project-475109.Fitabase_Data.Daily_activity` a
  LEFT JOIN weight_tracker_users w
    ON a.Id = w.Id
),
user_level_avg AS (
  SELECT
    Id,
    user_type,
    gun_segmenti,
    AVG(TotalSteps) as avg_steps,
    AVG(VeryActiveMinutes) as avg_active,
    AVG(SedentaryMinutes) as avg_sedentary
  FROM daily_activity_labeled
  GROUP BY Id, user_type, gun_segmenti
)

SELECT
  user_type,
  gun_segmenti,
  ROUND(AVG(avg_steps), 0) as ortalama_adim,
  ROUND(AVG(avg_active), 1) as cok_aktif_dakika,
  ROUND(AVG(avg_sedentary), 0) as hareketsiz_dakika,
  COUNT(*) as user_sayisi
FROM user_level_avg
GROUP BY user_type, gun_segmenti
ORDER BY user_type, gun_segmenti;
