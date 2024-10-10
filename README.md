# market_analysis

## Resume
**title** : Supermarket analysis

In this project I will demonstrate SQL skills and techniques that usually used to explore and analyze a data. SQL is one of program language that were used widely on processing data, especially as the data analist. This project encompasses not only creating data base, inputing data into database, conducting exploratory data analysis (EDA) but also answering business related questions. The data was collected from [Kaggle dataset](https://www.kaggle.com/datasets/faresashraf1001/supermarket-sales/data)

## Goal
1. **Creating Database**. Creating and populating supermarket database with the provided data.
2. **EDA**. Performing simple data analysis to understand the dataset.
3. **Buisness Analysis**. Answering question by using SQL to get insight for buisness.

## Project consults
### 1. Providing Database
1. **Preparing Database**. Using simple SQL syntax, `supermarket` has been created.
2. **Generating Table**. `market` table was created to store the data sales. The table consist of Invoice ID, branch, city, customer, gender, product_line, unit_price, quantity, tax 5%, sales, date, time, payment, cogs, gross margin percentage, gross income and rating. A buisness question will be answering based on data on the table.
```sql
CREATE DATABASE Supermarket;
USE supermarket;

DROP TABLE IF exists market;
CREATE TABLE market (
Invoice_ID VARCHAR (50) NOT NULL PRIMARY KEY,
Branch VARCHAR (50) NOT NULL,
City VARCHAR (30) NOT NULL,
Customer VARCHAR (50) NOT NULL,
Gender VARCHAR (20) NOT NULL,
Product_line VARCHAR (100) NOT NULL,
Unit_price DECIMAL (10,2) NOT NULL,
Qty INT NOT NULL,
Tax_5 FLOAT (6,4) NOT NULL,
Sales INT,
date DATE NOT NULL,
time TIME NOT NULL,
Payment VARCHAR (40) NOT NULL,
Cogs DECIMAL (10,2) NOT NULL,
gross_margin_prcntg FLOAT (11,2),
gross_income DECIMAL (12,2),
Rating FLOAT (2,1)
)
```

