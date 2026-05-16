# 🚲 Bike Sales Dashboard

An interactive Excel dashboard analysing 1,000+ customer records to uncover bike purchase behaviour across demographics, income brackets, commute distances, and geographies.

---

## 📌 Project Overview

This project explores what drives a customer to purchase a bike. Using a real-world-style dataset of 1,026 customers, the analysis segments buyers by age, income, gender, occupation, region, and commute distance to surface actionable marketing and sales insights — all inside a single, interactive Excel workbook.

Project Link: https://docs.google.com/spreadsheets/d/1cbdcr3Z65QOBpQwAJB3evHhffUXN3-VV/edit?usp=sharing&ouid=107644530890509605192&rtpof=true&sd=true

Report: C:/Users/Shivansh/Desktop/BIKE_SALE_DASHBOARD.html

---

## 🗂️ Dataset

| Property | Detail |
|---|---|
| Source | Kaggle (Bike Buyers Dataset) |
| Records | 1,026 customers |
| Target variable | `Purchased Bike` (Yes / No) |
| Class split | 495 purchased (48.2%) · 531 did not (51.8%) |


---

## 🔧 Tools & Tech Stack

- **Microsoft Excel** — pivot tables, charts, slicers, conditional formatting
- **Pivot Tables** — aggregation and cross-tabulation across all dimensions
- **Slicers** — interactive filters (Region, Marital Status, Education)
- **INDEX-MATCH & SUMIFS** — dynamic formula-driven calculations
- **Charts** — bar, line, and clustered column visuals

---

## 🗃️ Workbook Structure

| Sheet | Purpose |
|---|---|
| `bike_buyers` | Raw source data (1,026 rows × 13 columns) |
| `Working sheet` | Cleaned & transformed data (age brackets, standardised labels) |
| `Pivot table` | Aggregated summaries powering the dashboard visuals |
| `dashboard` | Final interactive dashboard with charts and slicers |

---

## 📊 Key Analyses & Insights

### 1. Income vs Bike Purchase
- Customers who purchased a bike had a **higher average income** than non-buyers.
- Male buyers showed higher average incomes than female buyers in both the purchased and non-purchased groups.

### 2. Commute Distance
- The **0–1 Miles** bracket had the highest number of bike purchases — short-commute customers are the primary buyers.
- Purchase rate drops significantly beyond **5 miles**, suggesting bikes are primarily used for short-distance commuting.

### 3. Age Brackets
- Customers aged **31–54 (Middle Age)** form the largest buyer segment.
- Both younger (Adolescent) and older (Senior 55+) brackets show lower conversion rates.
- The **35–50 age bracket** shows approximately **40% higher conversion** than other groups.

### 4. Regional Distribution
- Data spans **3 regions**: Europe, Pacific, and North America.
- All three regions are represented in the dashboard and can be filtered independently via slicers.

### 5. Occupation & Education
- **Professional and Management** occupations correlate with higher bike purchase rates.
- Customers with **Bachelors or Graduate Degrees** show stronger purchase intent than those with partial education.

---

## 📈 Dashboard Features

- **3 interactive slicers** — filter the entire dashboard by Marital Status, Region, and Education level simultaneously.
- **Income by gender & purchase** — clustered bar chart comparing average income across buyer segments.
- **Commute distance analysis** — line chart showing purchase volume at each commute band.
- **Age bracket breakdown** — bar chart segmenting buyers by life-stage group.
- All charts update dynamically when slicer selections change — no manual refresh needed.

---


## 📁 File Structure

```
bike-sales-dashboard/
│
├── BIKE_SALE_DASHBOARD.xlsx     # Main workbook (raw data + dashboard)
└── README.md                    # Project documentation
```

---

## 💡 Skills Demonstrated

- Advanced Excel (Pivot Tables, VLOOKUP, INDEX-MATCH, SUMIFS, nested IFs)
- Data cleaning and standardisation
- Customer segmentation and demographic analysis
- Interactive dashboard design with slicers
- Deriving business insights from raw transactional data

---

## 👤 Author

**Shivansh Arya**  
B.Tech – Electrical & Electronics Engineering, IIT Patna  
https://www.linkedin.com/in/shivansharya/ · [GitHub](#) · shivansharya.iitp@gmail.com
