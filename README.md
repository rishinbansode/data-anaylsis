# Swiggy Restaurant Data Analysis

## Table of Contents

* [Project Overview](#project-overview)
* [Business Understanding](#business-understanding)
* [Data Understanding](#data-understanding)
* [Data Cleaning](#data-cleaning)
* [Technologies Used](#technologies-used)
* [Project Approach](#project-approach)
* [Setup](#setup)
* [Project Status](#project-status)
* [Credits](#credits)

## Project Overview

This project analyzes a Swiggy restaurant dataset using PostgreSQL and SQL.

The goal is to clean, transform, and analyze the data to identify meaningful patterns related to restaurants, cuisines, ratings, and locations.

## Business Understanding

The analysis aims to understand:

* Restaurant distribution by location
* Popular cuisine categories
* Rating patterns
* Rating count patterns
* Other insights from the restaurant dataset

## Data Understanding

The dataset contains restaurant information such as:

* Restaurant name and ID
* Ratings and rating counts
* Cuisine
* Area and city
* License information

## Data Cleaning

The raw data was cleaned and transformed using SQL.

Key tasks included:

* Created a staging table
* Checked for duplicates
* Handled invalid and missing values
* Transformed rating-count categories
* Split cuisine and location fields
* Standardized inconsistent values
* Created additional cuisine categories
* Converted data types where required

Detailed SQL queries are available in:

`sql/01_data_cleaning.sql`

## Technologies Used

* PostgreSQL
* SQL
* pgAdmin

## Project Approach


## Setup

1. Install PostgreSQL and pgAdmin.
2. Import the dataset into PostgreSQL.
3. Run `sql/01_data_cleaning.sql`.

> The original dataset is not included in this repository.

## Project Status

**In Progress**

* Data Cleaning: Completed
* Exploratory Data Analysis: Upcoming
* Insights: Upcoming

## Credits

Swiggy restaurant dataset used for educational and analytical purposes.

This project is part of my learning journey in SQL and Data Analytics.
