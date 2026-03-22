WITH sleep_sessions AS (
  -- Her uyku oturumunun başlangıç ve süresini belirliyoruz
  SELECT 
    Id,
    logId,
    MIN(sleep_time) as uyku_baslangic,
    TIMESTAMP_DIFF(MAX(sleep_time), MIN(sleep_time), MINUTE) as toplam_dakika
  FROM `capstone-project-475109.Fitabase_Data.v_Minute_Sleep_cleaned`
  GROUP BY 1, 2
),
gece_uykulari AS (
  -- Sadece gece uykularını (3 saat+ ve gece vakti) filtreliyoruz
  SELECT * FROM sleep_sessions
  WHERE toplam_dakika >= 180 
    AND (EXTRACT(HOUR FROM uyku_baslangic) >= 20 OR EXTRACT(HOUR FROM uyku_baslangic) <= 5)
),
weight_groups AS (
  -- Kullanıcıları segmentlere ayırıyoruz
  SELECT DISTINCT CAST(Id AS STRING) as Id, 'Weight_Tracker' as segment 
  FROM `capstone-project-475109.Fitabase_Data.v_weight_log_cleaned`
),
final_data AS (
  -- Segment ve saat bazlı ana tabloyu kuruyoruz
  SELECT 
    CASE WHEN w.segment IS NOT NULL THEN 'Weight-Tracker' ELSE 'Non-Tracker' END as user_segment,
    EXTRACT(HOUR FROM g.uyku_baslangic) as start_hour,
    COUNT(*) as record_count
  FROM gece_uykulari g
  LEFT JOIN weight_groups w ON g.Id = w.Id
  GROUP BY 1, 2
)

-- Yüzdesel dağılımı ve tablo formatını üretiyoruz
SELECT 
  CONCAT(FORMAT('%02d', start_hour), '.00-', FORMAT('%02d', IF(start_hour=23, 0, start_hour+1)), '.00') as Time_Interval,
  -- Her segment için ham sayıları alıyoruz
  MAX(CASE WHEN user_segment = 'Weight-Tracker' THEN record_count ELSE 0 END) as Weight_Tracker,
  MAX(CASE WHEN user_segment = 'Non-Tracker' THEN record_count ELSE 0 END) as Non_Tracker,
  -- Her segment için kendi içindeki yüzdeyi hesaplıyoruz
  ROUND(MAX(CASE WHEN user_segment = 'Weight-Tracker' THEN record_count ELSE 0 END) / 
    SUM(MAX(CASE WHEN user_segment = 'Weight-Tracker' THEN record_count ELSE 0 END)) OVER() * 100, 0) as Weight_Tracker_Pct,
  ROUND(MAX(CASE WHEN user_segment = 'Non-Tracker' THEN record_count ELSE 0 END) / 
    SUM(MAX(CASE WHEN user_segment = 'Non-Tracker' THEN record_count ELSE 0 END)) OVER() * 100, 0) as Non_Tracker_Pct
FROM final_data
GROUP BY start_hour
ORDER BY 
  CASE WHEN start_hour >= 20 THEN start_hour - 24 ELSE start_hour END;