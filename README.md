# 🍔 Fast Food Restaurant Analysis — SQL Case Study

## 📖 Overview
This project focuses on analyzing **sales performance**, **customer behavior**, and **restaurant profitability** using SQL.  
It includes schema creation, analytical queries, custom functions, and materialized views — all built from scratch using PostgreSQL.  
The goal is to understand revenue trends, customer loyalty, and restaurant efficiency without relying on external BI tools.

---

## 🧱 Project Structure
| File | Description |
|------|--------------|
| `schema_setup.sql` | Defines the database schema for restaurants, menu items, customers, and orders |
| `sample_data.sql` | Inserts sample data for testing and query validation |
| `basic_queries.sql` | Basic selections, filtering, and sorting operations |
| `aggregation_and_groupby.sql` | Total orders, total sales, and average values |
| `join_and_analysis.sql` | Multi-table joins and performance analysis |
| `advanced_queries.sql` | Customer loyalty, city segmentation, and restaurant performance |
| `casestudy.sql` | Retention, basket analysis, and profitability studies |
| `RFM_ANALYSIS.sql` | Recency-Frequency-Monetary segmentation and KPI summary |
| `function_and_procedure.sql` | Custom SQL functions and materialized views for automated reporting |

---

## 📊 Key Insights
- **Customer Loyalty:** Identifies top repeat customers and their spending patterns.  
- **Menu Performance:** Highlights the most profitable and popular food items.  
- **Restaurant Comparison:** Shows sales performance across multiple restaurants.  
- **RFM Segmentation:** Classifies customers into High, Medium, and Low value groups.  
- **Revenue Trends:** Tracks daily and monthly revenue growth.  

---

## 🧠 Tools & Technologies
- **Database:** PostgreSQL  
- **Language:** SQL / PL-pgSQL  
- **IDE:** pgAdmin / DBeaver  
- **Version Control:** Git & GitHub  
- *(Optional: Power BI or Tableau can be connected later for dashboards)*

---

## 🧩 Entity Relationship Diagram (ERD)

```mermaid
erDiagram
    RESTAURANTS {
        int restaurant_id PK
        varchar name
        varchar location
        int opening_year
    }

    MENU_ITEMS {
        int item_id PK
        int restaurant_id FK
        varchar item_name
        varchar category
        decimal price
    }

    CUSTOMERS {
        int customer_id PK
        varchar full_name
        varchar gender
        int age
        varchar city
    }

    ORDERS {
        int order_id PK
        int customer_id FK
        int item_id FK
        date order_date
        int quantity
        decimal total_amount
    }

    RESTAURANTS ||--o{ MENU_ITEMS : "offers"
    MENU_ITEMS ||--o{ ORDERS : "includes"
    CUSTOMERS ||--o{ ORDERS : "places"
🖼️Visual Insights
📊 RFM Analysis

📈 Dynamic KPI Summary

🧩 Cohort Month Analysis — Customer Retention

💰 Highest Margin Food Items

🏪 Restaurant Performance Over Time

👥 Customer Spend Function Output

🗺️ ERD Diagram

How to Run

Create Database:
Open PostgreSQL or pgAdmin and create a new database, e.g. fastfood_db.

Execute Scripts in Order:

schema_setup.sql
sample_data.sql
basic_queries.sql
aggregation_and_groupby.sql
join_and_analysis.sql
advanced_queries.sql
casestudy.sql
RFM_ANALYSIS.sql
function_and_procedure.sql

Validate:
Run the functions:

SELECT * FROM get_monthly_sales('Chick-fil-A');
SELECT * FROM get_customer_spend('Oshawa');

Author

Brittney Gohil
📍 Oshawa, Ontario — Canada
🔗 [LinkedIn](https://www.linkedin.com/in/brittney-gohil-74bb7a308/)  
💻 [GitHub](https://github.com/Brittneygohil/)
