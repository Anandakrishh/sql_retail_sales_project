Create database project1;
use project1;
create table reatil_sales
(
transactions_id int primary key,
sale_date date,
sale_time time,
customer_id int,
gender varchar(10),
age	int,
category varchar(20),
quantity int,	
price_per_unit float,	
cogs float,
total_sale float

);
select count(*) from reatil_sales;

select * from retail_sales
where transactions_id is null
or
sale_date is null
or	
sale_time is null
or
customer_id	is null
or
gender	is null
or
age	is null
or
category is null
or
quantity is null or quantity = ' '
or
price_per_unit	is null or price_per_unit= ' '
or
cogs is null or cogs= ' '
or
total_sale is null or total_sale = ' ';

#1 Write a SQL query to retrieve all columns for sales made on '2022-11-05:

select * from retail_sales
where sale_date = '2022-11-05';

#2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:

SELECT * FROM retail_sales
WHERE category = 'Clothing' 
AND sale_date BETWEEN '2022-11-01' AND '2022-11-30'
and quantity >=4;

#3 Write a SQL query to calculate the total sales (total_sale) for each category.:

select 
category,
sum(total_sale) as total_sales,
count(total_sale) as no_of_items
from retail_sales
group by category;

#4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:

select round(avg(age),2) as avg_age
from retail_sales
where category = 'Beauty';

#5 Write a SQL query to find all transactions where the total_sale is greater than 1000.:

select * from  retail_sales
where total_sale >1000;

#6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:

select  category, gender, count(*) as transaction
from retail_sales
group by category, gender
order by 1;

#7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:


WITH MonthlySales AS (
    SELECT 
        YEAR(sale_date) AS year,
        MONTH(sale_date) AS month,
        ROUND(AVG(total_sale), 2) AS avg_sale 
    FROM retail_sales
    GROUP BY 1, 2
)
SELECT year, month, avg_sale
FROM (
    SELECT 
        year, 
        month, 
        avg_sale,
        RANK() OVER (PARTITION BY year ORDER BY avg_sale DESC) AS no
    FROM MonthlySales
) ranked_sales
WHERE no = 2;

#8 **Write a SQL query to find the top 5 customers based on the highest total sales **:

select customer_id as customer,
sum(total_sale) as high_Sales
from retail_sales
group by 1 
order by 2 desc
limit 5;

#9 Write a SQL query to find the number of unique customers who purchased items from each category.:

select 
distinct(count(customer_id)) as customber,
category as catagory
from retail_sales
group by 2;

#10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
with hourly_sales
as (
select *,
case 
when hour(sale_time) between 1 and 12 then 'morning'
when hour(sale_time) between 13 and 17 then 'afternoon'
else 'night'
end as shift
from retail_sales 
)
select 
shift,
count(total_sale)
from hourly_sales
group by shift;