```markdown
# GoOutside Retail Analytics & Data Warehouse

A data warehousing and business intelligence solution for **GoOutside**, an established outdoor and camping equipment supplier. 

When GoOutside's previous data analyst left unexpectedly, 3.5 years of transactional data (2015–2018) remained locked across four disconnected CSV files. This project migrates that legacy data into a **Google BigQuery** data warehouse, transforms raw transactions into optimized aggregation tables using **GoogleSQL**, and connects the output directly to **Google Sheets** and **Looker Studio** dashboards to solve core operational and financial challenges.

---

## 🏗️ Architecture & Data Pipeline

```text
[Raw Legacy CSVs] 
       │
       ▼
[Google BigQuery Data Warehouse]
  `lyrical-lyceum-510107-s2.GoOutside`
       │
       ├── 01_master_table.sql (Cleaning, Joins, Revenue/Profit Logic)
       ├── 02_sarah_order_methods.sql (Pre-aggregated Channel Performance)
       └── 03_dustin_retailer_analysis.sql (Market Concentration & Targets)
       │
       ├─────────────────────────────────┐
       ▼                                 ▼
[Google Sheets Connector]      [Google Looker Studio]
  (Connected Sheets)             (Executive Dashboard)

```

---

## 🗄️ SQL Transformation Logic (`sql/`)

All queries were built in GoogleSQL within BigQuery to power downstream tools:

1. **`sql/01_master_table.sql`**: Combines daily sales, retailer details, product metadata, and order method codes. Standardizes date formats into true `DATE` objects and computes revenue and net profit per transaction line.
2. **`sql/02_sarah_order_methods.sql`**: Pre-aggregates daily performance by channel. Looker Studio initially experienced date-filter timeouts when querying raw transaction logs; pre-aggregating the dataset eliminated latency and allowed instantaneous date filtering.
3. **`sql/03_dustin_retailer_analysis.sql`**: Evaluates country-level market concentration using window functions. Automatically classifies markets as **Dominated** or **Competitive** and calculates growth targets per retailer.

---

## 👥 Stakeholder Requirements & Key Findings

### 1. Finance & Channel Efficiency — Sarah (Finance Manager)

* **Objective:** Sarah needed an audit of all sales channels to identify low-margin, labor-intensive order methods that could be phased out to reduce operational overhead.
* **Findings:**
* **Web Orders** are the core business driver, generating **€909.60M (72.7% of total revenue)** across 124,225 order lines.
* **Telephone** (€157.89M) and **E-mail** (€87.90M) represent strong secondary B2B channels.
* **Fax** (€2.88M revenue / 280 orders) and **Special** (€4.51M revenue / 370 orders) combined account for **less than 0.6% of total revenue** over 3.5 years.


* **Recommendation:** Immediately phase out Fax and Special order processing to eliminate manual data entry costs and redirect wholesale buyers to the automated web portal.

### 2. Retailer Growth & Market Strategy — Dustin (Head of Retail Partnerships)

* **Objective:** Dustin needed visibility into GoOutside's 289 retail partners across 21 countries to decide where to expand retailer count vs. where to deepen existing volume.
* **Market Classification Rule:**
* **Dominated Markets:** Top 3 retailers hold **≥75%** of national market share (e.g., Switzerland at 87%).
* **Competitive Markets:** Top 3 retailers hold **<75%** of national market share (e.g., US, France, Germany).


* **Strategic Actions:**
* **In Dominated Markets:** Focus on deepening top accounts with a target of **+10% revenue per retailer (RpR)** (e.g., boosting Switzerland's RpR from €12.85M to €14.13M).
* **In Competitive Markets:** Focus on partner acquisition with a target **+15% increase in active retailer count** (e.g., expanding the US network from 54 to 63 retailers, Germany from 15 to 18, France from 20 to 23).



---

## 📈 Dashboard & Visualizations

> **Data Retention Note:** The underlying BigQuery dataset runs on a Sandbox tier. Static visual references are maintained below to preserve dashboard documentation.

### Executive Overview & Revenue Trends

### Sales Channel Analysis (Sarah's Focus)

### Market Composition & Retailer Targets (Dustin's Focus)

---

## 🔗 Live Deliverables

* **Google Sheets Connected Master Dataset:** [View Connected Sheet](https://docs.google.com/spreadsheets/d/14I-wuXAWBcSyBKDccp7QSdfG7IuBLNDmz6EDYcR9Ilo/edit?gid=1578801980#gid=1578801980)

```

```
