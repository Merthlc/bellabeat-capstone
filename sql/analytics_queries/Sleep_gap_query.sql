WITH date_diffs AS (
  SELECT 
    Id,
    Activity_Date,
    LAG(Activity_Date) OVER(PARTITION BY Id ORDER BY Activity_Date) AS prev_date
  FROM (
    SELECT DISTINCT Id, DATE(PARSE_DATETIME('%m/%e/%Y %I:%M:%S %p', Activity_Minute)) AS Activity_Date
    FROM `capstone-project-475109.Fitabase_Data.Minute_Sleep`
  )
)
SELECT 
  Id,
  MAX(DATE_DIFF(Activity_Date, prev_date, DAY)) AS max_gap_days
FROM date_diffs
GROUP BY Id
HAVING max_gap_days <= 3 -- Arada hiç 1 günden fazla boşluk bırakmamış olanları getir