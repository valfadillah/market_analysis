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
```sql
SELECT * 
FROM market
WHERE date = '2019-03-27';
```
2. **Write a SQL query to retrieve all transactions  where the category is 'Home and lifestyle' and the quantity sold is more than 5 in the month of March-2019.**
```sql
Select 
	Product_line,
    qty
FROM
(
SELECT 
	product_line,
    qty,
    EXTRACT(month from date) as date
FROM market
)t1 
WHERE
	product_line = 'Home and lifestyle'
AND
	date = 3
AND 
	qty >5
;
```
3. **Write a SQL query to calculate the total sales (total_sale) for each product_line.**
```sql
SELECT 
	product_line,
    SUM(sales) as total_sales,
    COUNT(*) AS total_order
FROM market
GROUP BY 1
ORDER BY 2 DESC;
```
4. **Write a SQL query to find the average age of quantity that purchased from the 'Sports and Travel' category.**
```sql
SELECT 
	Product_line,
    ROUND(AVG(qty),2) AS avg_qty
FROM market
WHERE
	Product_line = 'Sports and travel'
GROUP BY 1;
```
5. **Write a SQL query to find the total number of transactions (Invoice_id) made by each gender in each categor.**
```sql
SELECT 
	Product_line,
    gender,
    COUNT(Invoice_ID) AS total_transaction
FROM market
GROUP BY 1,2
ORDER BY 3 DESC;
```
6. **Write a SQL query to calculate the average sale for each month. Find out best selling month**
```sql
WITH CTE
AS
(SELECT 
	branch,
    product_line,
    ROUND(AVG(sales),2) AS average_sales,
    EXTRACT(MONTH from date) as Month,
    ROW_NUMBER () OVER(PARTITION BY product_line ORDER BY AVG(sales)) AS rn
FROM market
GROUP BY 1,2,4
ORDER BY 2)
SELECT
	branch,
    product_line,
    average_sales,
    month
FROM CTE
WHERE 
	rn =1
ORDER BY 2 DESC;
```
7. **Write a SQL query to who is the highest sales customer.**
```sql
SELECT 
	customer,
    SUM(sales) as total_sales
FROM market
GROUP BY 1;
```
8. **Write a SQL query to find the top 3 product_line based on the highest gross_income**
```sql
SELECT
	Product_line,
    SUM(gross_income) AS total_gross
FROM market
GROUP BY 1
LIMIT 3;
```
9. **Write a SQL query to create each shift and number of orders (Morning <12, Afternoon Between 12 & 14, Evening >14)**
```sql
SELECT
	COUNT(*) AS total_orders,
	shift_time
FROM    
(SELECT *,
	CASE
		WHEN EXTRACT(hour FROM time) < 11 then 'Morning'
        WHEN EXTRACT(hour FROM time) BETWEEN 11 AND 16 then 'Afternoon'
		WHEN EXTRACT(hour FROM time) BETWEEN 16 AND 18 then 'Evening'
        WHEN EXTRACT(hour FROM time) > 18 then 'Night'
	END
		AS shift_time
FROM market)t1
GROUP BY 2
ORDER BY 1 DESC;

SELECT 
	city
    ,Product_line,
    SUM(gross_income) AS gross
FROM market
GROUP BY 1,2
ORDER BY 3 DESC;
```

10. **Create a classification product based on price. Dividing producnt into 3 category**
```sql
WITH CTE AS
(SELECT 
	Product_line,
    CASE WHEN unit_price >= 80 THEN 1 ELSE 0 END AS Supreme,
    CASE WHEN unit_price >= 50 THEN 1 ELSE 0 END AS Intermediate,
	CASE WHEN unit_price <= 49 THEN 1 ELSE 0 END AS Entry_level
from market)
SELECT 
	product_line,
    SUM(supreme) AS Supreme,
    SUM(intermediate) AS :Intermediate,
    SUM(entry_level) AS Entry_level
FROM CTE
GROUP BY 1;
```
### 4. Ascertainig
1. **Customer Demographic:** The dataset contains various information such as city, branch and gender. Retriving the data, customer behavior can be anlyzed. The number of memberships is 40% higher than that of regular customers. This increase can be attributed to the advantages offered to members compared to ordinary consumers, such as exclusive discounts, loyalty points, easier access to information, and year-end holiday rewards.
A total of 563 memberships have been recorded, with 354 of them are women, representing 62% of the total membership. This indicates the presence of social behavior in membership enrollment. Several factors contributed such as women's awareness of added value, their more structured shopping preferences, and the influence of social environmnet. These tendencies are reflected in the top five transactions classified by product category, Top 5 were dominated by female members.
2. **Sales information:** From a sales perspective, there is no significant increase in the total number of sales. Customers tend to spend more on food and beverages, followed by fashion and accessories. Although fashion had a higher number of orders, totaling 178, food sales ranked first in terms of total revenue. This suggests that the price of the food items purchased is relatively high. This can be observed from the product classification data.
3. **Time hour:** There is asignificant number of customers, 541 in total, shopped during the afternoon. Fascinatingly, food orders ranked fifth out of six categories during this time. However, being ranked fifth is not necessarily a negative outcome, as there were still 85 food purchases made in the afternoon. Food remains the top category overall, with the highest number of total orders during both the afternoon and evening, recording 20 and 46 orders, respectively. This data also highlights that the period between 11 AM and 4 PM is the prime time for sellers, offering the greatest opportunity for sales.

## Verdict
This project provides a thorough introduction to SQL for data analysts. It covers key areas such as setting up databases, data cleaning, exploratory data analysis, and crafting SQL queries aimed at addressing business questions. The insights gained from this project can support decision-making by revealing trends in sales, customer behavior, and product performance.

## Author - Nuaval D.F
This project is part of my portfolio as a data analyst. SQL is the programming language used throughout the project. 


    
   

