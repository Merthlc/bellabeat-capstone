# 🌿 Bellabeat Smart Device Analysis
### Google Data Analytics Professional Certificate — Capstone Project

![SQL](https://img.shields.io/badge/Tool-Google%20BigQuery-blue?logo=google-cloud)
![Excel](https://img.shields.io/badge/Tool-Microsoft%20Excel-217346?logo=microsoft-excel&logoColor=white)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen)
![Data](https://img.shields.io/badge/Data-FitBit%20Fitness%20Tracker-orange)

---

## 📌 Project Overview

This project is the capstone case study for the **Google Data Analytics Professional Certificate**. The objective is to analyze smart device fitness data to uncover behavioral trends that can inform the marketing strategy of **Bellabeat**, a health-focused technology company for women.

The analysis follows the full data analysis lifecycle: **Ask → Prepare → Process → Analyze → Share → Act**.

---

## 🎯 Business Questions

1. What are some trends in smart device usage?
2. How could these trends apply to Bellabeat customers?
3. How could these trends help influence Bellabeat's marketing strategy?

---

## 🗂️ Repository Structure

```
bellabeat-capstone/
│
├── README.md
├── report/
│   └── bellabeat_report.md
└── sql/
    ├── analytics_queries/
    │   └── (queries)
    ├── data_quality_check/
    │   └── (queries)
    └── view_building/
        └── (queries)
```

---

## 📊 Dataset

- **Source:** [FitBit Fitness Tracker Data](https://www.kaggle.com/datasets/arashnic/fitbit) — Kaggle (CC0: Public Domain)
- **Size:** 11 CSV files covering 33 Fitbit users over ~2 months (April–May 2016)
- **Metrics:** Daily activity, hourly steps/calories/intensities, minute-level sleep/METs/heart rate, weight logs
- **Storage:** Google BigQuery (`capstone-project-475109.Fitabase_Data`)

> ⚠️ **Limitations:** Small sample size (33 users), no demographic data, collected in 2016. All findings should be treated as directional.

---

## 🛠️ Tools & Technologies

| Tool | Purpose |
|---|---|
| Google BigQuery (SQL) | Data storage, cleaning, and analysis |
| Microsoft Excel | Data visualization, dashboard creation, and final presentation |

---

## 🧹 Data Processing Highlights

All 11 tables were cleaned and standardized into BigQuery views. Key steps included:

- **Cross-table duplicate audit** via `UNION ALL` scan across all 11 tables — 525 duplicates found exclusively in `Minute_Sleep`
- **Column-level null audit** via `COUNTIF(column IS NULL)` — 31 nulls found exclusively in `Weight_Log.fat`
- **Valid Day filter** applied to `Daily_Activity`: ≥2,000 steps, ≥1,200 calories, ≤1,380 sedentary minutes
- **INNER JOIN** strategy used across all hourly/minute tables to anchor records to validated activity days
- **User-level filter** applied to `Weight_Log` (instead of date-level join) to preserve infrequent weigh-in records

---

## 🔍 Analysis Summary

All six analyses used a consistent segmentation: **Weight-Trackers** (users who logged weight) vs **Non-Trackers**.

| Analysis | Key Finding |
|---|---|
| General Overview | Weight-Trackers walk 16% more daily, burn 6% fewer calories — consistent with female BMR patterns |
| WeightLogged vs Typical Day | Activity on weight-logging days is identical to normal days — tracking is a trait, not a trigger |
| Device Usage | 91% loyalty rate (Weight-Trackers) vs 67% (Non-Trackers); 41% fewer zombie days |
| Weekend vs Weekday | Weight-Trackers increase activity +11% on weekends; Non-Trackers drop -10% |
| Sleep Distribution | Weight-Trackers have 24% fewer disturbed sleep minutes and 7% higher sleep efficiency |
| Calorie Distribution | Weight-Trackers show structured 15:00–17:00 peaks; Non-Trackers spike reactively at 18:00–20:00 |

---

## 💡 Key Insights

Three patterns emerged consistently across all analyses:

1. **Behavioral Consistency** — Weight-Trackers maintain stable activity regardless of day type (weekday, weekend, or weigh-in day)
2. **Structured Daily Rhythm** — Planned afternoon activity peaks vs reactive evening bursts
3. **Long-Term Engagement** — Higher loyalty, lower churn, fewer disengagement signals

> **Central finding:** Weight tracking functions as a **behavioral anchor** — an indicator of a disciplined lifestyle, not a short-term motivational spike.

---

## 📣 Recommendations for Bellabeat

| # | Recommendation |
|---|---|
| 1 | **Reframe the value proposition** — shift from "track your progress" to "support your structure" |
| 2 | **Weekend engagement campaign** — target Non-Trackers with weekend-specific nudges and challenges |
| 3 | **Sleep Quality Score feature** — combine sleep metrics into a single actionable score |
| 4 | **Zombie Day detection** — re-engagement trigger after consecutive low-activity days |
| 5 | **Premium upsell targeting** — concentrate subscription marketing on the Weight-Tracker profile |

---

## 📁 Full Report

The complete report covering all six phases of the analysis is available here:
👉 [`report/bellabeat_report.md`](report/bellabeat_report.md)

---

## 👤 Author

**[Kerim Mert Halıcı]**  
Google Data Analytics Certificate — Capstone Project  
[LinkedIn](https://www.linkedin.com/in/kmerthalici/) · [GitHub](https://github.com/Merthlc)
