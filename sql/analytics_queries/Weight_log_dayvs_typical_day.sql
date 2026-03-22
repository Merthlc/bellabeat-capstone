WITH weight_tracker_users AS (
  -- Önce sadece kilo takibi yapan 8-9 kişiyi ayıklıyoruz
  SELECT DISTINCT Id FROM `capstone-project-475109.Fitabase_Data.v_weight_log_cleaned`
),
weight_log_dates AS (
  -- Hangi gün tartıya çıkılmış? (Saat farkını atıp sadece tarihe odaklanıyoruz)
  SELECT DISTINCT Id, record_date 
  FROM `capstone-project-475109.Fitabase_Data.v_weight_log_cleaned`
),
daily_activity_categorized AS (
  -- Aktivite tablosunu tartı günü olup olmamasına göre etiketliyoruz
  SELECT 
    a.Id,
    a.ActivityDate,
    a.TotalSteps,
    a.Calories,
    a.SedentaryMinutes,
    a.FairlyActiveMinutes,
    a.VeryActiveMinutes,
    CASE WHEN w.record_date IS NOT NULL THEN 'Weight-logged Day' ELSE 'Normal Day' END as gun_tipi
  FROM `capstone-project-475109.Fitabase_Data.Daily_activity` a
  INNER JOIN weight_tracker_users u ON a.Id = u.Id -- Sadece kilo takibi yapanların aktiviteleri
  LEFT JOIN weight_log_dates w ON a.Id = w.Id AND a.ActivityDate = w.record_date
)

SELECT 
  gun_tipi,
  ROUND(AVG(TotalSteps), 0) as ortalama_adim,
  ROUND(AVG(Calories), 0) as ortalama_kalori,
  ROUND(AVG(SedentaryMinutes), 1) as Sedentary_Minutes,
  ROUND(AVG(FairlyActiveMinutes), 1) as Fairly_Active_Minutes,
  ROUND(AVG(VeryActiveMinutes), 1) as Very_Active_Minutes,
  COUNT(*) as Total_Days_Count
FROM daily_activity_categorized
GROUP BY 1;