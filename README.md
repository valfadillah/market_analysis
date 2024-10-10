![Supermarket in another world](https://github.com/valfadillah/market_analysis/blob/main/oxana-melis-loDPKt_srQ0-unsplash.jpg)
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
### 2. Data Exploration
1. **Record Count**. Determine total number on dataset
2. **Identifying**. Explatory dataset using simple operation to possessed information on dataset
```sql
SELECT COUNT(*) FROM market;
SELECT city, COUNT(*) FROM market GROUP BY 1;
SELECT branch, COUNT(*) FROM market GROUP BY 1;
SELECT gender, COUNT(*) FROM market GROUP BY 1;
SELECT product_line, COUNT(*) FROM market GROUP BY 1 ORDER BY 2 DESC;
SELECT product_line, SUM(gross_income)As total_income FROM market GROUP BY 1 ORDER BY 2 DESC;
SELECT product_line, ROUND(SUM(tax_5),2)As total_tax FROM market GROUP BY 1 ORDER BY 2 DESC;
SELECT product_line, SUM(sales)AS total_sales FROM market GROUP BY 1 ORDER BY 2 DESC;
SELECT time_serving, COUNT(*)  FROM market GROUP BY 1;
```
### 3. Buisness problems and solution
Through SQL queries were developed to overcome spesific buisness question 
1. **Write a SQL query to retrieve all columns for sales made on '2019-03-27'.**
2. **Write a SQL query to retrieve all transactions  where the category is 'Home and lifestyle' and the quantity sold is more than 5 in the month of March-2019.**
3. **Write a SQL query to calculate the total sales (total_sale) for each product_line.**
4. **Write a SQL query to find the average age of quantity that purchased from the 'Sports and Travel' category.**
5. **Write a SQL query to find the total number of transactions (Invoice_id) made by each gender in each categor.**
6. **Write a SQL query to calculate the average sale for each month. Find out best selling month**
7. **Write a SQL query to who is the highest sales customer.**
8. **Write a SQL query to find the top 3 product_line based on the highest gross_income**
9. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 14, Evening >14)**
   

