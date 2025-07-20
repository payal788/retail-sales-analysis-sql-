-- sql retail sales analysis
create database sales_analysis;
-- create table
drop table if exists retail_sales;
create table retail_sales(
     transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);
select * from retail_sales
limit 10
 -- data cleaning
    select count(*) from retail_sales
    select * from retail_sales
    SELECT * FROM retail_sales
WHERE 
    sale_date IS NULL
	OR 
	sale_time IS NULL
	OR
	customer_id IS NULL 
	OR 
    gender IS NULL
	OR 
	category IS NULL
	OR 
    quantity IS NULL
	OR 
	price_per_unit IS NULL 
	OR 
	cogs IS NULL;
	DELETE FROM retail_sales
WHERE 
    sale_date IS NULL
	OR
	sale_time IS NULL 
	OR
	customer_id IS NULL 
	OR 
    gender IS NULL 
	OR 
	age IS NULL 
	OR 
	category IS NULL 
	OR 
    quantity IS NULL
	OR
	price_per_unit IS NULL
	OR 
	cogs IS NULL;

  -- data exploration 
  -- how many sales we have ?
  select count (*) total_sales from retail_sales

-- how many unique cutomers  we have ?
select count (distinct customer_id) as total_sale from retail_sales

-- how many unique categories  we have ?

select distinct category from retail_sales

--data analysis key problems and answers 

-- Q1: Write a SQL query to retrieve all columns for sales made on '2022-11-05:
       select * from retail_sales
	   where sale_date='2022-11-05'

-- Q2:  Write a SQL query to retrieve all transactions where the category is 'Clothing' and 
         -- the quantity sold is more than 4 in the month of Nov-2022:

      SELECT * FROM retail_sales
      WHERE 
      category = 'Clothing'
      AND 
      TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
      AND
      quantity >= 4

-- Q3:  Write a SQL query to calculate the total sales (total_sale) for each category.:

         SELECT category,
		 SUM(total_sale) AS NET_SALES,
		count(*) total_orders
		from retail_sales
		group by 1;
		 
-- Q4:   Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:

          select 
		  round(avg(age), 2) as avg_age
		  from retail_sales
		  where category='Beauty'

 -- Q5:    Write a SQL query to find all transactions where the total_sale is greater than 1000.:     
           select * from retail_sales
		   where  total_sale>1000;

 -- Q6:  Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:

         select count(transactions_id)as total_transactions,category,gender
		 from retail_sales
         group by category ,gender;

 -- Q7: Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
       
	   SELECT 
       year,
       month,
        avg_sale
        FROM 
      (    
       SELECT 
       EXTRACT(YEAR FROM sale_date) as year,
        EXTRACT(MONTH FROM sale_date) as month,
        AVG(total_sale) as avg_sale,
       RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
        FROM retail_sales
        GROUP BY 1, 2
        ) as t1
        WHERE rank = 1

 -- Q8: Write a SQL query to find the top 5 customers based on the highest total sales **:

     select customer_id,sum(total_sale)
	 from retail_sales
	 group by customer_id
	 order by sum(total_sale) desc
	 limit 5;

 -- Q9:  Write a SQL query to find the number of unique customers who purchased items from each category.:

		 select 
		 count (distinct customer_id) ,category
		 from retail_sales
          group by category;
   
 -- Q10: Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):      

         WITH hourly_sale
         AS
         (
           SELECT *,
           CASE
           WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
           WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
           ELSE 'Evening'
           END as shift
          FROM retail_sales
          )
         SELECT 
         shift,
         COUNT(*) as total_orders    
         FROM hourly_sale
         GROUP BY shift

--- end of queries .
		




	 
