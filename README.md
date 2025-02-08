# **📦 Comprehensive Data Warehouse for Food Delivery System 🚀**

## **1. Overview** 📝
This project aims to develop a robust data warehouse for a food delivery system, enabling efficient data management, analysis, and reporting. The warehouse supports various business operations, including order management, customer insights, restaurant performance tracking, delivery monitoring, and promotional analysis.

## **2. Database Schema and Table Relationships** 🔗
The data warehouse consists of multiple tables, categorized as dimension, fact, and audit tables, interconnected through foreign keys to maintain data integrity and facilitate complex queries.

### **📊 Dimension Tables:**
- **🕒 datetime_dim_tb**: Stores date and time attributes like day of the week, week number, month, quarter, and year. Used for tracking order placement, deliveries, and reviews.
  - **Joins:** Orders, delivery_person_dim_tbl, and review_dim_tbl via `datetime_id`.

- **👤 customer_dim_tbl**: Contains customer details, including name, email, phone, and address, to analyze customer behavior and preferences.
  - **Joins:** Orders, review_dim_tbl via `customer_id`.

- **🍔 menu_dim_tbl**: Stores details of menu items such as name, price, availability, and associated restaurant.
  - **Joins:** restaurant_dim_tbl via `restaurant_id`.

- **🏬 restaurant_dim_tbl**: Contains restaurant details like name, address, opening hours, and location for performance tracking and location-based insights.
  - **Joins:** menu_dim_tbl, promotion_dim_tbl, Orders via `restaurant_id`.

- **🌍 geography_dim_tbl**: Stores geographical details (city, state, country, region, latitude, longitude) for location-based analysis.
  - **Joins:** restaurant_dim_tbl, Orders via `geo_id`.

- **🚴‍♂️ delivery_person_dim_tbl**: Contains delivery personnel details, including name, age, salary, and availability, for tracking delivery performance.
  - **Joins:** delivery via `delivery_person_id`, datetime_dim_tb via `time_id`.

- **🎉 promotion_dim_tbl**: Stores promotional details such as discount value and validity period to track promotional effectiveness.
  - **Joins:** restaurant_dim_tbl, Orders via `promotion_id`.

- **⭐ review_dim_tbl**: Stores customer reviews, including review text, rating, and source, to analyze customer satisfaction.
  - **Joins:** Orders, customer_dim_tbl via `review_id`, `customer_id`.

### **📌 Fact Tables:**
- **📦 Orders**: Central fact table storing order details, including customer ID, restaurant ID, promotion ID, delivery ID, and order status.
  - **Joins:** customer_dim_tbl, promotion_dim_tbl, restaurant_dim_tbl, datetime_dim_tb, geography_dim_tbl, delivery via foreign keys.

- **🚚 delivery**: Tracks delivery details, including status, estimated vs actual delivery times, and delays.
  - **Joins:** Orders via `order_id`, delivery_person_dim_tbl via `delivery_person_id`.

### **🛠 Audit Tables:**
- **📄 menu_audit**: Tracks menu item price changes over time.
  - **Joins:** menu_dim_tbl via `item_id`.

- **🏷 promotion_audit**: Tracks changes in promotional discounts over time.
  - **Joins:** promotion_dim_tbl via `promotion_id`.

- **👷‍♂️ delivery_person_audit**: Tracks changes in delivery personnel salaries over time.
  - **Joins:** delivery_person_dim_tbl via `delivery_person_id`.

## **3. Technologies Used** 💻
- **🗄 Database Management System (DBMS):** MySQL or PostgreSQL for structured data storage.
- **🔍 SQL:** Used for database querying and management.
- **📐 Data Modeling:** Star schema structure with optimized fact and dimension tables.
- **🔄 ETL Tools:** Apache Airflow, Talend, or Informatica for data extraction, transformation, and loading (ETL).
- **📊 Data Visualization:** Tableau, Power BI, or Looker for dashboards and reports.

## **4. Key Features and Enhancements** 🚀
- **📂 Centralized Data Storage:** Consolidates order, customer, restaurant, delivery, and promotional data in a single repository.
- **📈 Historical Data Tracking:** Audit tables allow trend analysis and business decision-making.
- **📡 Scalability:** The star schema enables easy expansion by adding new dimensions or fact tables.
- **✅ Data Integrity:** Foreign key constraints maintain consistency across tables.
- **⚡ Performance Optimization:** Indexed dimension tables enhance query execution speed.

## **5. Database Normalization and Optimization** 🔄
The schema follows a hybrid approach, leveraging normalization principles within dimension tables while maintaining a denormalized star schema structure for efficiency:
- **1️⃣ First Normal Form (1NF):** Atomic values with each column storing a single value per row.
- **2️⃣ Second Normal Form (2NF):** Non-key attributes in dimension tables fully depend on the primary key.
- **3️⃣ Third Normal Form (3NF):** Elimination of transitive dependencies using foreign key references (e.g., `geo_id` in restaurant_dim_tbl instead of redundant location storage).

## **6. Use Cases** 🎯
- **🛍 Customer Insights:** Analyzing customer behavior and satisfaction using customer_dim_tbl, Orders, and review_dim_tbl.
- **🍽 Restaurant Performance:** Evaluating restaurant sales, menu trends, and promotional effectiveness.
- **🚛 Delivery Optimization:** Monitoring delivery performance, delays, and personnel efficiency.
- **📍 Geographical Analysis:** Using geography_dim_tbl for region-based insights.
- **💰 Financial Reporting:** Revenue tracking, discount analysis, and profit assessment using Orders.
- **🕰 Historical Analysis:** Using audit tables to track price and salary changes over time.
