# 🧹 Data Cleansing & Layoff Trend Analysis — SQL

A complete end-to-end SQL project that cleans a real-world tech layoffs dataset and uncovers layoff trends across companies, industries, and years using advanced MySQL techniques.

---

## 📌 Project Overview

Raw data is messy. This project takes a Kaggle layoffs dataset — full of duplicates, inconsistent formatting, null values, and mixed date formats — and transforms it into a clean, analysis-ready table using a structured multi-stage SQL pipeline. The cleaned data is then used to rank the top companies by layoffs across every year from 2020 to 2023.

Project link : 
---

## 🗂️ Dataset

| Property | Detail |
|---|---|
| Source | Kaggle — Tech Layoffs Dataset |
| Records cleaned | 2,000+ rows |
| Duplicates removed | 300+ entries |
| Inconsistent entries standardised | 500+ company names, industries, country codes |
| Target output | Clean, analysis-ready `layoff_staging2` table |

### Columns

| Column | Type | Description |
|---|---|---|
| company | TEXT | Company name |
| location | TEXT | City / location of layoffs |
| industry | TEXT | Industry sector (e.g. Crypto, Tech, Retail) |
| total_laid_off | INT | Number of employees laid off |
| percentage_laid_off | TEXT | Percentage of workforce laid off |
| date | DATE | Date of layoff event |
| stage | TEXT | Funding stage (Series A, B, Post-IPO, etc.) |
| country | TEXT | Country of the layoff event |
| funds_raised_millions | INT | Total funds raised by company (USD millions) |

---

## 🔧 Tools & Tech Stack

- **MySQL** — all cleaning, transformation, and analysis
- **Window Functions** — `ROW_NUMBER() OVER (PARTITION BY ...)` for duplicate detection
- **CTEs** — Common Table Expressions for staging logic
- **String Functions** — `TRIM()`, `TRIM(TRAILING ...)`, `STR_TO_DATE()`, `LIKE`
- **CASE Statements** — for standardising categorical values
- **JOIN on Self** — to populate null industry values from matching company rows

---

## 🏗️ Pipeline Architecture

The project follows a **5-stage SQL pipeline**:

```
layoffs (raw)
    ↓  Stage 1 — Copy to staging table
layoff_staging
    ↓  Stage 2 — Flag & remove duplicates
    ↓  Stage 3 — Standardise text & dates
    ↓  Stage 4 — Handle NULLs & blanks
    ↓  Stage 5 — Drop helper columns
layoff_staging2 (clean)
    ↓  Analysis
Top Layoffs by Company & Year
```

---

## 🔍 Step-by-Step Process

### Stage 1 — Create Staging Table
```sql
CREATE TABLE layoff_staging LIKE layoffs;
INSERT INTO layoff_staging SELECT * FROM layoffs;
```
Never modify raw data. All work happens in staging tables.

---

### Stage 2 — Remove Duplicates
```sql
WITH duplicate_cte AS (
  SELECT *,
    ROW_NUMBER() OVER (
      PARTITION BY company, location, industry, total_laid_off,
      percentage_laid_off, date, stage, country, funds_raised_millions
    ) AS row_num
  FROM layoff_staging
)
SELECT * FROM duplicate_cte WHERE row_num > 1;
```
- Used `ROW_NUMBER()` partitioned across all 9 key columns to detect true duplicates
- Created `layoff_staging2` with a `row_num` column, then deleted all rows where `row_num > 1`
- **Removed 300+ duplicate entries**

---

### Stage 3 — Standardise Text & Dates
```sql
-- Trim whitespace from company names
UPDATE layoff_staging2 SET company = TRIM(company);

-- Unify crypto industry variants
UPDATE layoff_staging2 SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

-- Remove trailing period from country names
UPDATE layoff_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';

-- Convert text dates to DATE format
UPDATE layoff_staging2
SET date = STR_TO_DATE(date, '%m/%d/%Y');

ALTER TABLE layoff_staging2 MODIFY COLUMN date DATE;
```
- Standardised **500+ inconsistent company names, industries, and country codes**
- Converted the `date` column from raw text (`'03/11/2020'`) to a proper `DATE` type for time-series analysis

---

### Stage 4 — Handle NULLs & Blanks
```sql
-- Convert blank strings to NULL for consistency
UPDATE layoff_staging2 SET industry = NULL WHERE industry = '';

-- Self-join to fill NULL industries from matching company rows
UPDATE layoff_staging2 t1
JOIN layoff_staging2 t2 ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL AND t2.industry IS NOT NULL;

-- Remove rows with no layoff data at all
DELETE FROM layoff_staging2
WHERE total_laid_off IS NULL AND percentage_laid_off IS NULL;
```
- Used a **self-join** to intelligently backfill NULL `industry` values from other rows of the same company (e.g., Airbnb rows with missing industry populated from existing Airbnb rows)
- Dropped rows where both `total_laid_off` and `percentage_laid_off` were NULL — unusable records

---

### Stage 5 — Drop Helper Column
```sql
ALTER TABLE layoff_staging2 DROP COLUMN row_num;
```
Clean final table ready for analysis.

---

## 📊 Analysis Results — Top Layoffs by Year

Used `DENSE_RANK()` to find the top 5 companies with the most layoffs per year:

| Company | Year | Total Laid Off | Rank |
|---|---|---|---|
| Uber | 2020 | 7,525 | 1 |
| Booking.com | 2020 | 4,375 | 2 |
| Groupon | 2020 | 2,800 | 3 |
| Airbnb | 2020 | 1,900 | 4 |
| Agoda / PaisaBazaar | 2020 | 1,500 | 5 |
| Katerra | 2021 | 2,434 | 1 |
| Zillow | 2021 | 2,000 | 2 |
| Better.com | 2021 | 900 | 3 |
| Dropbox | 2021 | 315 | 4 |
| Bounce | 2021 | 200 | 5 |
| Meta | 2022 | 11,000 | 1 |
| Amazon | 2022 | 10,000 | 2 |
| Cisco | 2022 | 4,100 | 3 |
| Peloton | 2022 | 4,084 | 4 |
| Carvana / Philips | 2022 | 4,000 | 5 |
| Google | 2023 | 12,000 | 1 |
| Microsoft | 2023 | 10,000 | 2 |
| Ericsson | 2023 | 8,500 | 3 |
| Amazon | 2023 | 8,000 | 4 |
| Salesforce / Dell | 2023 | 8,000 / 6,650 | 5 |

**Key observation:** 2022–2023 saw a dramatic spike — Meta, Google, Microsoft, and Amazon alone account for 43,000+ layoffs, dwarfing 2020 numbers.

---

## 📁 File Structure

```
layoff-sql-analysis/
│
├── layoff_cleaning.sql        # Full data cleaning pipeline (Stages 1–5)
├── layoff_analysis.sql        # Trend analysis & ranking queries
└── README.md                  # Project documentation
```

---

## 💡 Skills Demonstrated

- Multi-stage SQL pipeline design using staging tables
- Duplicate detection with `ROW_NUMBER()` window functions and CTEs
- Text standardisation using `TRIM()`, `LIKE`, `CASE`, `STR_TO_DATE()`
- NULL handling with self-joins to backfill missing values
- Time-series trend analysis with `GROUP BY` and aggregate functions
- Ranking with `DENSE_RANK()` window function across yearly partitions

---

## 👤 Author

**Shivansh Arya**  
B.Tech – Electrical & Electronics Engineering, IIT Patna  
[LinkedIn](#) · [GitHub](#) · shivansharya.iitp@gmail.com
