# Ooshman Food Business — PostgreSQL Analysis

A data analytics project built on a PostgreSQL database simulating a Lebanese food business (**Ooshman**) operating across 3 shops in Canberra, Australia. Originally created to practise SQL and schema design, now extended with Python analysis and visualisations.

**Purpose:** Practising multi-table SQL with real business queries, Python data analysis across 1M+ rows, and data visualisation on a relational database.

---

## The Database

| Detail | Value |
|---|---|
| Database | `ooshdb` |
| Business | Ooshman — Lebanese food, 3 Canberra locations |
| Orders | 1,000,000 |
| Customers | 1,000,000 |
| Order items | 500,000 |
| Menu items | 101 across 12 categories |
| Date range | January 2023 – September 2025 |
| Avg order value | $46.45 |

### Schema

| Table | Rows | Description |
|---|---|---|
| orders | 1,000,000 | Every customer order with timestamp, value, shop |
| customers | 1,000,000 | Customer profile — name, gender, DOB, address |
| order_items | 500,000 | Line items linking orders to menu items |
| menu_items | 101 | Items with price and category |
| categories | 12 | Deals, Manoosh, Wraps, Pizzas, Salads, Drinks, etc. |
| shops | 3 | Greenway, Weston, Gungahlin |
| staff | 30 | Staff with role and shop assignment |
| payment_methods | 4 | Cash, PC Eftpos, Mobile Eftpos, Paid Online |
| delivery_methods | 3 | Pickup, Delivery, Dine-In |

---

## Project Structure

```
ooshdb-vivanti-project/
├── README.md
├── .env                         (not committed — DB credentials)
├── .gitignore
├── ooshdb_DDL.sql               (full database DDL)
├── ooshdb_ERD.png               (entity relationship diagram)
├── sql/
│   ├── 01_sales_analysis.sql
│   ├── 02_customer_analysis.sql
│   ├── 03_menu_analysis.sql
│   ├── 04_operations_analysis.sql
│   └── 05_shop_deepdive.sql
├── python/
│   ├── 01_sales_analysis.py
│   ├── 02_customer_analysis.py
│   ├── 03_menu_analysis.py
│   ├── 04_operations_analysis.py
│   └── 05_shop_deepdive.py
└── outputs/                     (30 PNG charts)
```

---

## How to Run

**Prerequisites:** PostgreSQL running with `ooshdb` database loaded (see `ooshdb_DDL.sql`).

**Run SQL analysis (open in psql or pgAdmin):**
```bash
psql -U postgres -d ooshdb -f sql/01_sales_analysis.sql
psql -U postgres -d ooshdb -f sql/02_customer_analysis.sql
psql -U postgres -d ooshdb -f sql/03_menu_analysis.sql
psql -U postgres -d ooshdb -f sql/04_operations_analysis.sql
psql -U postgres -d ooshdb -f sql/05_shop_deepdive.sql
```

**Generate visualisations:**
```bash
python3 python/01_sales_analysis.py
python3 python/02_customer_analysis.py
python3 python/03_menu_analysis.py
python3 python/04_operations_analysis.py
python3 python/05_shop_deepdive.py
```

Charts are saved to `outputs/`.

---

## Analysis Modules

### 01 — Sales Analysis
| Question | Technique |
|---|---|
| Total revenue & avg order value by shop | GROUP BY + SUM, AVG |
| Monthly revenue & order volume trend | DATE_TRUNC, dual-axis |
| Payment method breakdown | Window %, pie + bar |
| Order value distribution | CASE WHEN brackets |
| Monthly revenue by shop | GROUP BY shop + month |
| Quarterly revenue by shop | EXTRACT(QUARTER), grouped bar |

### 02 — Customer Analysis
| Question | Technique |
|---|---|
| Age group distribution | DATE_PART + AGE(), CASE WHEN |
| Order frequency bands | CTE + CASE WHEN buckets |
| Gender split by shop | GROUP BY shop + gender |
| Top 10 highest-spending customers | GROUP BY customer, ORDER BY SUM |
| Avg order value by age group | JOIN customers + orders |
| Monthly unique customers trend | COUNT(DISTINCT customer_id) |

### 03 — Menu & Category Analysis
| Question | Technique |
|---|---|
| Revenue by category | JOIN 3 tables, GROUP BY category |
| Top 15 best-selling items by quantity | SUM(quantity), ORDER BY |
| Top 15 highest revenue items | SUM(line_total), ORDER BY |
| Category revenue share | Window % pie chart |
| Price range by category (min/avg/max) | MIN, AVG, MAX |
| Orders containing each category | COUNT(DISTINCT order_id) |

### 04 — Operations Analysis
| Question | Technique |
|---|---|
| Orders by hour of day | EXTRACT(HOUR), dual-axis |
| Orders by day of week | EXTRACT(DOW), TO_CHAR |
| Year-over-year comparison (2023 vs 2024) | EXTRACT(YEAR), multi-line |
| Monthly order value distribution | PERCENTILE_CONT (p25/p50/p75) |
| Top 20 busiest weeks | DATE_TRUNC('week'), ranked bar |
| Hour x day of week heatmap | Pivot heatmap |

### 05 — Shop Deep-Dive
| Question | Technique |
|---|---|
| Full KPI comparison across shops | Revenue share window % |
| Monthly revenue trend per shop | Multi-line by shop |
| Top 5 best-selling items per shop | RANK() OVER PARTITION BY shop |
| Staff count by role and shop | JOIN staff + shops |
| Payment method mix by shop | Window % PARTITION BY shop |
| Avg order value per shop by year | EXTRACT(YEAR), annotated line |

---

## Key Findings

- **Ooshman Greenway** generates the highest revenue — the busiest of the 3 locations
- **Paid Online** and **PC Eftpos** together account for the majority of orders
- **Manoosh and Wraps** are the top revenue-generating categories — core to the brand
- **Lunch hours (12PM–2PM)** are peak ordering times; evenings (6PM–8PM) are the second peak
- **Friday and Saturday** see the highest weekly order volumes
- **Customer order frequency is heavily skewed** — majority of customers place only 1–3 orders
- **25–34 age group** is the largest customer segment and highest spender per order
- Revenue grew steadily from 2023 to 2024 across all 3 shops

---

## What I Practised

**SQL**
- Multi-table `JOIN` across 5+ tables
- `DATE_TRUNC`, `EXTRACT`, `TO_CHAR` for time-based analysis
- `PERCENTILE_CONT` for order value distribution
- `RANK() OVER (PARTITION BY shop_id)` for per-shop rankings
- Window functions: `SUM() OVER ()`, `PARTITION BY` for percentages
- CTEs (`WITH`) for frequency band analysis
- `DATE_PART('year', AGE(date_of_birth))` for customer age calculations

**Python**
- Connecting to PostgreSQL via `psycopg2` on a 1M-row dataset
- Dual-axis charts (`twinx`) for count + value on one figure
- Stacked and grouped bar charts for multi-category comparisons
- Heatmaps for hour x day patterns
- Pie charts with percentage labels
- Annotated line charts for year-over-year comparisons
- `pd.to_datetime` and `dt.strftime` for date formatting

---

## Tools

| Tool | Purpose |
|---|---|
| PostgreSQL 17 | Database |
| psql / pgAdmin 4 | DDL, queries, schema management |
| Python 3 | Analysis + visualisation |
| pandas | Data manipulation |
| matplotlib / seaborn | Charts |
| VS Code | Development |

---

*Built by Masud — data analytics learner, career changer, work in progress.*
