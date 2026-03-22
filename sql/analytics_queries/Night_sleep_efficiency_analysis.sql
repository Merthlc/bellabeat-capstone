WITH sleep_sessions AS (
  SELECT 
    Id,
    logId,
    MIN(activity_time) as uyku_baslangic,
    -- Senin dediğin: Yatakta geçen toplam süre (Max - Min)
    TIMESTAMP_DIFF(MAX(activity_time), MIN(activity_time), MINUTE) as yatakta_gecen_toplam_dakika,
    -- Benim eklediğim: Sadece uykuda (value = 1) geçen net süre
    COUNTIF(sleep_value = 1) as net_uyku_dakikasi,
    -- Uyanık (3) ve Huzursuz (2) geçen dakikalar
    COUNTIF(sleep_value = 3) as uyanik_dakika,
    COUNTIF(sleep_value = 2) as huzursuz_dakika
  FROM `capstone-project-475109.Fitabase_Data.v_minute_sleep_cleaned`
  GROUP BY 1, 2
),
gece_uykulari_temiz AS (
  -- SENİN FİLTREN: Birebir aynısını uyguluyoruz
  SELECT * FROM sleep_sessions
  WHERE yatakta_gecen_toplam_dakika >= 180 
    AND (EXTRACT(HOUR FROM uyku_baslangic) >= 20 OR EXTRACT(HOUR FROM uyku_baslangic) <= 5)
),
weight_groups AS (
  SELECT DISTINCT Id, 'Tracker' as segment FROM `capstone-project-475109.Fitabase_Data.v_weight_log_cleaned`
)

SELECT 
  CASE WHEN w.segment IS NOT NULL THEN 'Weight Tracker' ELSE 'Non-Tracker' END as user_segment,
  -- 1. Senin bulduğun: Toplam süre (6.94 beklediğimiz yer)
  ROUND(AVG(g.yatakta_gecen_toplam_dakika / 60.0), 2) as avg_total_time_in_bed,
  -- 2. Net uyku süresi
  ROUND(AVG(g.net_uyku_dakikasi / 60.0), 2) as avg_actual_sleep_time,
  -- 3. Fark (Yatakta geçen uyanık/huzursuz süre)
  ROUND(AVG((g.yatakta_gecen_toplam_dakika - g.net_uyku_dakikasi)), 1) as avg_disturbed_minutes_in_bed,
  COUNT(*) as nb_of_record_times
FROM gece_uykulari_temiz g
LEFT JOIN weight_groups w ON g.Id = w.Id
GROUP BY 1;