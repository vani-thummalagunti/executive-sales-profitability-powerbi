# 📈 Executive Sales & Profitability Intelligence Dashboard

[![Power BI](https://img.shields.io/badge/Power_BI_Desktop-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)](https://powerbi.microsoft.com/)
[![DAX](https://img.shields.io/badge/DAX-Calculations-blue?style=for-the-badge)](./dax/all_measures.dax)
[![Power Query](https://img.shields.io/badge/Power_Query-M_Code-teal?style=for-the-badge)](./powerquery/etl_transformations.m)
[![Author](https://img.shields.io/badge/Author-Vani_Thummalagunti-purple?style=for-the-badge)](https://github.com/vani-thummalagunti)

An executive retail business intelligence solution built in **Microsoft Power BI Desktop** analyzing $5.96M in sales, diagnosing discount margin leaks, and monitoring regional profitability across 5,000 enterprise orders.

---

## 📌 Executive Summary
* **Total Sales Revenue:** $5.96 Million
* **Net Operating Profit:** $1.14 Million
* **Operating Profit Margin:** **19.2%**
* **Total Orders Processed:** 5,000 (Average Order Value: $1,192)

---

## 🎯 Key Business Findings
1. **Category Margin Disparity:** **Technology** generates a strong **28.0% margin** ($666K profit), whereas **Furniture** drives $1.48M in gross sales but yields only an **8.9% margin**.
2. **The 20% Discount Trap:** Aggressive discounting exceeding **20%** on bulky furniture categories (Tables & Bookcases) consistently produced negative-margin loss leaders.
3. **Regional Leaders:** The **West Region ($1.68M sales, $345K profit)** leads all territories in bottom-line cash contribution.

---

## 🏗️ Data Architecture & Star Schema

```
+------------------------------+             +-------------------------------+
|         Dim_Customer         |             |          Dim_Product          |
+------------------------------+             +-------------------------------+
| CustomerID (PK)              |             | SubCategory (PK)              |
| CustomerSegment              |             | Category                      |
| Region                       |             +---------------+---------------+
+--------------+---------------+                             | (1)
               | (1)                                         |
               |                                             |
               | (*)                                         | (*)
+--------------+---------------------------------------------+---------------+
|                                 Fact_Orders                                |
+----------------------------------------------------------------------------+
| OrderID                                                                    |
| OrderDate                                                                  |
| CustomerID (FK)                                                            |
| SubCategory (FK)                                                           |
| Quantity                                                                   |
| Discount                                                                   |
| Sales                                                                      |
| Profit                                                                     |
+----------------------------------------------------------------------------+
```

---

## 📐 Core DAX Measures

```dax
// Total Revenue
Total Sales = SUM(Fact_Orders[Sales])

// Net Operating Profit
Total Profit = SUM(Fact_Orders[Profit])

// Operating Profit Margin %
Profit Margin % = DIVIDE([Total Profit], [Total Sales], 0)

// High Discount Sales % (Discounts >= 20%)
High Discount Sales % = 
VAR HighDiscountSales = CALCULATE(SUM(Fact_Orders[Sales]), Fact_Orders[Discount] >= 0.20)
RETURN DIVIDE(HighDiscountSales, SUM(Fact_Orders[Sales]), 0)

// Average Order Value (AOV)
Average Order Value = DIVIDE([Total Sales], COUNTROWS(Fact_Orders), 0)
```

---

## 🛠️ Data Cleaning & Transformations (Power Query M)
* **Promoted Headers & Typings:** Cleaned date and numeric datatypes.
* **Imputed Missing Sales Values:** Handled nulls in sales figures using quantity and average item pricing.

*(See full M-script in [`powerquery/etl_transformations.m`](./powerquery/etl_transformations.m))*

---

## 📁 Repository Structure
```text
├── README.md                      # Project documentation and schema
├── data/
│   ├── sales_raw.csv              # Source transactional dataset
│   ├── sales_cleaned.csv          # Cleaned dataset
│   ├── fact_orders.csv            # Star Schema Fact table
│   ├── dim_customer.csv           # Star Schema Dimension table
│   └── dim_product.csv            # Star Schema Dimension table
├── dax/
│   └── all_measures.dax           # Documented DAX measures
├── powerquery/
│   └── etl_transformations.m      # Power Query M code
└── dashboard/
    └── index.html                 # Interactive report layout preview
```

---

## 🚀 How to Run in Microsoft Power BI Desktop
1. Open **Power BI Desktop**.
2. Click **Get Data** > **Text/CSV** and import:
   * `data/dim_customer.csv`
   * `data/dim_product.csv`
   * `data/fact_orders.csv`
3. In **Model View**, establish 1-to-many single-direction relationships from Dimensions to Fact.
4. Create a `_Measures` table and paste the measures from `dax/all_measures.dax`.
5. Build report visuals:
   * **Cards:** Total Sales, Net Profit, Profit Margin %, Total Orders.
   * **Grouped Bar Chart:** Revenue vs Profit by Category.
   * **Donut Chart:** Profit Margin % by Category.
   * **Clustered Column Chart:** Regional Sales & Profit Contribution.
   * **Slicers:** Category, Customer Segment.

---

### Developed by **Vani Thummalagunti**
Connect on [LinkedIn](https://www.linkedin.com) | [GitHub Profile](https://github.com/vani-thummalagunti)
