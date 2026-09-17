# Swiggy Restaurant Data Analysis

## Table of Contents

1. [Project Overview](#project-overview)
2. [Business Understanding](#business-understanding)
3. [Data Understanding](#data-understanding)
4. [Data Cleaning](#data-cleaning)
5. [Technologies Used](#technologies-used)
6. [Project Approach](#project-approach)
7. [Setup](#setup)
8. [Project Status](#project-status)
9. [Credits](#credits)

---

## Project Overview

This project analyzes a Swiggy restaurant dataset using PostgreSQL and SQL.

The main objective is to explore restaurant data and identify patterns and opportunities that could help increase Swiggy sales.

The project covers data cleaning, transformation, exploratory data analysis, and extracting meaningful insights from the dataset.

---

## Business Understanding

The main objective of this analysis is to identify patterns and opportunities in the restaurant data that could potentially help increase Swiggy sales.

The analysis focuses on:

* Identifying cities and areas with high restaurant presence
* Understanding restaurant rating patterns
* Identifying popular and highly rated cuisine categories
* Analyzing restaurant pricing and cost patterns
* Identifying highly rated and popular restaurants
* Comparing cities and areas based on ratings and restaurant costs
* Identifying potential opportunities to improve restaurant performance and customer choices

---

## Data Understanding

The dataset contains information about restaurants listed on Swiggy.

Key columns include:

* Restaurant ID
* Restaurant Name
* Rating
* Rating Count
* Cuisine
* Area
* City
* Cost
* License Number

The dataset contains information that can be used to analyze restaurant distribution, ratings, cuisines, pricing, and location-based patterns.

---

## Data Cleaning

The raw data was cleaned and transformed using SQL and PostgreSQL.

Key tasks included:

* Created a staging table for data cleaning
* Checked for duplicate records
* Converted rating-count categories into ordinal numerical values
* Split cuisine information into separate categories
* Extracted area and city information
* Standardized text values using `TRIM()` and `INITCAP()`
* Standardized inconsistent cuisine values
* Created meaningful cuisine categories
* Converted rating values into a numeric data type
* Handled invalid and missing rating values
* Checked NULL values and missing-rating percentages
* Cleaned and converted restaurant cost values

Detailed cleaning queries are available in:

`sql/01_data_cleaning.sql`

---

## Technologies Used

* PostgreSQL
* SQL
* pgAdmin
* GitHub

---

## Project Approach

The project follows the following workflow:

**Data Understanding → Data Cleaning → Exploratory Data Analysis → Insights**

### Data Cleaning

The raw restaurant data was cleaned and transformed to make it suitable for analysis.

### Exploratory Data Analysis

SQL queries were used to analyze:

* Restaurant distribution by city and area
* Average restaurant ratings
* Cuisine categories and ratings
* Restaurant costs
* Highly rated restaurants
* Value-for-money patterns
* Restaurant counts by city

Detailed analysis queries are available in:

`sql/02_eda.sql`

---

## Setup

1. Install PostgreSQL and pgAdmin.
2. Create a PostgreSQL database.
3. Import the Swiggy dataset into PostgreSQL.
4. Create the `swiggy_staging` table.
5. Run:

`sql/01_data_cleaning.sql`

6. After completing the cleaning process, run:

`sql/02_eda.sql`

> The original dataset is not included in this repository.

---

## Project Status

**In Progress**

* Data Understanding: Completed
* Data Cleaning: Completed
* Exploratory Data Analysis: Completed
* Insights: In Progress
* Visualizations: Upcoming

---

## Credits

Swiggy restaurant dataset used for educational and analytical purposes.

This project is part of my learning journey in SQL and Data Analytics.
