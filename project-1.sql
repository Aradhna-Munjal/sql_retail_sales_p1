
create table retail_sale(
transactions_id int primary key ,
	sale_date	date ,
    sale_time	time ,
    customer_id	 int ,
    gender varchar(20),
	age int ,
	category varchar(50),
    quantity int, 
    price_per_unit float,
	cogs float,
	total_sale float

);
-- checking the null values in all the columns
select * from retail_sale
where 
	quantity is null
	or 
	transactions_id is null
	or sale_date is null
	or sale_time is null 
	or customer_id is null
	or gender is null
	or age is null
	or category is null
	or quantity is null
	or price_per_unit is null
	or cogs is null
	or total_sale is null;

-- deleting the records with null values
delete from retail_sale
where quantity is null
	or transactions_id is null
	or sale_date is null
	or sale_time is null 
	or customer_id is null
	or gender is null
	or age is null
	or category is null
	or quantity is null
	or price_per_unit is null
	or cogs is null
	or total_sale is null;

select * from retail_sale;


-- DATA EXPLORATION 
-- how many sales we had in total 

select count(sale_date) as total_sales from retail_sale;

-- how many unique customers we have
select count( DISTINCT customer_id) as total_customers from retail_sale;

-- how many unique customers we have(id's all customers)
select DISTINCT customer_id as total_customers from retail_sale;


-- how many unique categories we have(in number)
select count( DISTINCT category) as total_category from retail_sale;

-- how many unique categories we have(names)
select DISTINCT category as total_category from retail_sale;

-- Data Analysis & Business Key problems and answers

select * from retail_sale;

--Write a SQL query to retrieve all columns for sales made on '2022-11-05'.
select  * from retail_sale
where sale_date= '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' 
--     and the quantity sold is more than 10 in the month of November 2022


select * from retail_sale
where category='Clothing'
and
to_char(sale_date,'YYYY-MM')='2022-11'
and
quantity>=4

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category

select category,sum(total_sale) as sale_for_category, count(*) as total _orders from retail_sale
group by category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category

select round(avg(age),1) as avg_age 
from retail_sale
where category='Beauty';


-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category

select count(transactions_id) as total_trans,category,gender
from retail_sale
group by category,gender
order by category;



-- Q.7 Write a SQL query to calculate the average sale for each month 
--     and find out the best-selling month in each year

-- Generic formulas
-- extract year from date 
-- extract (year from sale_date) as year


-- extract month from date 
-- extract (month from sale_date) as month
select * from(
select
	extract (year from sale_date) as year,
	extract (month from sale_date) as month,
	avg(total_sale) as total_sale,
	rank() over(partition by extract (year from sale_date) order by avg(total_sale) desc )as rank
from retail_sale
group by year ,month
order by year ) as t1
where rank=1;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales


select customer_id distinct, sum(total_sale) as sale from retail_sale 
group by customer_id 
order by sale desc;


-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category


select count(distinct customer_id), category
from retail_sale
group by category;


-- Q.10 Write a SQL query to divide transactions into shifts and count the number of orders in each shift
--       (Example: Morning <= 12, Afternoon between 12 & 17, Evening > 17)

with hourly_sales
as
(
select *,
	case
		when extract (hour from sale_time)<12 then 'morning'
		when extract (hour from sale_time)between 12 and 17 then 'afternoon'
		else 'evening'
	end as shift
from retail_sale
)
select count(*) as total_orders, shift
from hourly_sales
group by shift;








--end of first project





