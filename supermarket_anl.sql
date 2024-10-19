CREATE DATABASE Supermarket;
USE supermarket;

DROP TABLE IF exists market;
CREATE TABLE joymart (
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
);
SELECT * FROM market;
ALTER TABLE market
	MODIFY COLUMN Time time;

-- EDA --------------------------------------------------------
-- ------------------------------------------------------------
SELECT COUNT(*) FROM market;
SELECT city, COUNT(*) FROM market GROUP BY 1;
SELECT branch, COUNT(*) FROM market GROUP BY 1;
SELECT gender, COUNT(*) FROM market GROUP BY 1;
SELECT product_line, COUNT(*) FROM market GROUP BY 1 ORDER BY 2 DESC;
SELECT product_line, SUM(gross_income)As total_income FROM market GROUP BY 1 ORDER BY 2 DESC;
SELECT product_line, ROUND(SUM(tax_5),2)As total_tax FROM market GROUP BY 1 ORDER BY 2 DESC;
SELECT product_line, SUM(sales)AS total_sales FROM market GROUP BY 1 ORDER BY 2 DESC;
SELECT time_serving, COUNT(*)  FROM market GROUP BY 1;
SELECT * FROM market
	WHERE
		Invoice_ID is null;

DELETE FROM market
		WHERE
		Invoice_ID is null;

ALTER TABLE market 
	ADD COLUMN time_serving VARCHAR(20);


select *
from 
(select 
	branch,
    sum(gross_income) as total_revenue,
	extract(month from `date`) as month,
    row_number () over (partition by branch order by  sum(gross_income)) as rn
    from market
    group by 1,3)t1
    WHERE rn = 1
    order by 2 desc
    ;
    
-- 1. Write a SQL query to retrieve all columns for sales made on '2019-03-27:
SELECT * 
FROM market
WHERE date = '2019-03-27';

--  2. Write a SQL query to retrieve all transactions  where the category is 'Home and lifestyle' and the quantity sold is more than 5 in the month of March-2019:

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

-- 3. Write a SQL query to calculate the total sales (total_sale) for each product_line.
SELECT 
	product_line,
    SUM(sales) as total_sales,
    COUNT(*) AS total_order
FROM market
GROUP BY 1
ORDER BY 2 DESC;

-- 4.Write a SQL query to find the average age of quantity that purchased from the 'Sports and Travel' category.:
SELECT 
	Product_line,
    ROUND(AVG(qty),2) AS avg_qty
FROM market
WHERE
	Product_line = 'Sports and travel'
GROUP BY 1;

-- 6. Write a SQL query to find the total number of transactions (Invoice_id) made by each gender in each category.
SELECT 
	Product_line,
    gender,
    COUNT(Invoice_ID) AS total_transaction
FROM market
GROUP BY 1,2
ORDER BY 3 DESC;

-- 7.Write a SQL query to calculate the average sale for each month. Find out best selling month.
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

-- 8.Write a SQL query to who is the highest sales customer
SELECT 
	customer,
    SUM(sales) as total_sales
FROM market
GROUP BY 1;

SELECT
	gender,
    SUM(CASE WHEN customer = 'normal' THEN 1 ELSE 0 END) AS Normal,
    SUM(CASE WHEN customer = 'member' THEN 1 ELSE 0 END) AS membership
FROM market
GROUP BY 1;

-- 9.Write a SQL query to find the top 3 product_line based on the highest gross_income
SELECT
	Product_line,
    SUM(gross_income) AS total_gross
FROM market
GROUP BY 1
LIMIT 3;

-- 10. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
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

with T2 AS
(SELECT *,
	CASE WHEN EXTRACT(hour FROM time) < 11 then 1 ELSE 0 END AS Morning,
    CASE WHEN EXTRACT(hour FROM time) BETWEEN 11 AND 16 then 1 ELSE 0 END AS Afternoon,
	CASE WHEN EXTRACT(hour FROM time) BETWEEN 16 AND 18 then  1 ELSE 0 END AS Evening,
	CASE WHEN EXTRACT(hour FROM time) > 18 then 1 ELSE 0 END AS Night
FROM market)
select Product_line,
		SUM(morning),
        SUM(Afternoon),
        SUM(Evening),
        SUM(Night)
FROM T2
GROUP BY 1
order by 3 desc;

SELECT 
	city
    ,Product_line,
    SUM(gross_income) AS gross
FROM market
GROUP BY 1,2
ORDER BY 3 DESC;
        

-- classification product
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
    SUM(intermediate) AS Intermediate,
    SUM(entry_level) AS Entry_level
FROM CTE
GROUP BY 1
ORDER BY 2,3,4 DESC;

    
