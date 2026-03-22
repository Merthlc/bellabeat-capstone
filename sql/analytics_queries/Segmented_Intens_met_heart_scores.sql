WITH user_segments AS (
  -- Kimin hangi grupta olduğunu belirliyoruz
  SELECT DISTINCT ID,
  CASE 
    WHEN ID IN (SELECT DISTINCT ID FROM `capstone-project-475109.Fitabase_Data.v_weight_log_cleaned`) THEN 'Weight_Tracker' 
    ELSE 'Non_Tracker' 
  END as user_segment
  FROM `capstone-project-475109.Fitabase_Data.Daily_activity`
),
user_heartbeat AS (
  -- Kullanıcı bazlı ortalama kalp atışı (Join patlamasını önlemek için)
  SELECT Id, AVG(Value) as user_avg_hb
  FROM `capstone-project-475109.Fitabase_Data.v_heartrate_seconds_cleaned`
  GROUP BY 1
),
user_mets AS (
  -- Kullanıcı bazlı ortalama MET (Join patlamasını önlemek için)
  SELECT Id, AVG(METs / 10.0) as user_avg_met
  FROM `capstone-project-475109.Fitabase_Data.v_minute_met_cleaned`
  GROUP BY 1
)

SELECT 
  s.user_segment,
  COUNT(DISTINCT a.Id) as User_Count,
  ROUND(AVG(a.TotalSteps), 0) as Avg_Steps,
  -- Intensity: Aktif dakikaların toplam takılan süreye oranı
  ROUND(AVG(SAFE_DIVIDE((a.VeryActiveMinutes + a.FairlyActiveMinutes + a.LightlyActiveMinutes), 
    (a.VeryActiveMinutes + a.FairlyActiveMinutes + a.LightlyActiveMinutes + a.SedentaryMinutes))), 2) as Avg_Intensity,
  ROUND(AVG(m.user_avg_met), 2) as Avg_METs,
  ROUND(AVG(h.user_avg_hb), 2) as Avg_Heartbeat
FROM `capstone-project-475109.Fitabase_Data.Daily_activity` a
JOIN user_segments s ON a.Id = s.Id
LEFT JOIN user_heartbeat h ON a.Id = h.Id
LEFT JOIN user_mets m ON a.Id = m.Id
WHERE a.TotalSteps > 0 -- 0 adım günlerini eliyoruz
GROUP BY 1;