WITH all_users AS (
  -- Ana havuz: Uygulamayı kullanan herkes (33 kişi)
  SELECT DISTINCT Id FROM `capstone-project-475109.Fitabase_Data.Daily_activity`
),
sleep_users AS (
  -- Uyku verisi olanlar (23-24 kişi)
  SELECT DISTINCT Id FROM `capstone-project-475109.Fitabase_Data.v_minute_sleep_cleaned`
),
weight_users AS (
  -- Kilo takibi yapanlar (8 kişi)
  SELECT DISTINCT Id FROM `capstone-project-475109.Fitabase_Data.v_weight_log_cleaned`
)

SELECT 
  COUNT(DISTINCT a.Id) as toplam_kullanici,
  COUNT(DISTINCT s.Id) as uyku_verisi_olanlar,
  COUNT(DISTINCT w.Id) as kilo_takibi_yapanlar,
  -- ASIL BOMBA: Hem uyku hem kilo verisi olan o "VIP" grup kaç kişi?
  COUNT(DISTINCT CASE WHEN s.Id IS NOT NULL AND w.Id IS NOT NULL THEN a.Id END) as hem_uyku_hem_kilo_takibi_yapanlar
FROM all_users a
LEFT JOIN sleep_users s ON a.Id = s.Id
LEFT JOIN weight_users w ON a.Id = w.Id;