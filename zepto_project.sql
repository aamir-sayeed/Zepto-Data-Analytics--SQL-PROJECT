drop table if exists zepto;

create table zepto(
sku_id SERIAL PRIMARY KEY,
category VARCHAR(120),
name VARCHAR(150) NOT NULL,
mrp NUMERIC(8,2),
discountPercent NUMERIC(5,2),
availableQauntity INTEGER,
discountedSellingPrice NUMERIC(8,2),
weightInGms INTEGER,
outOfStock BOOLEAN,
quantity INTEGER
);

--data exploration
Select count(*) from zepto

--sample data
select * from zepto 
limit 10;


-- null values
select * from zepto
where name is NULL
or 
category is NULL
or 
mrp is NULL
or
discountPercent is NULL
or
availableQauntity is NULL
or
discountedSellingPrice is NULL
or
weightInGms is NULL
or
outOfStock is NULL
or
quantity is NULL

-- different product categories
Select distinct category
from zepto
order by category;

-- products in stock vs out of stock
select outOfStock, count(sku_id)
from zepto
group by outOfStock;

-- product names present multiple times
select name, count(sku_id) as "Number of SKUs"
from zepto
group by name 
having count(sku_id) > 1
order by count(sku_id) DESC;

--data cleaning

--product with price = 0
select * from zepto
where mrp = 0 or discountedSellingPrice = 0

delete from zepto
where mrp = 0;

--convert paise to rupee
update zepto
set mrp = mrp/100.0,
discountedSellingPrice = discountedSellingPrice/100.0;

select mrp ,discountedSellingPrice from zepto

--1) Find the top 10 best-value products based on the discount percentage.
select distinct name, mrp ,discountPercent from zepto
order by discountPercent desc
limit 10;

--2) What are the products with high MRP but out of stock
select distinct name, mrp
from zepto
where outOfStock = True  and mrp > 300
order by mrp desc;

-- 3) Calculate the estimated revenue for each category
select category,
sum(discountedSellingPrice * availableQauntity) as total_revenue
from zepto
group by category
order by total_revenue

-- 4) Find all products where MRP is greater than 500 and discount is less than 10%
select distinct name , mrp,discountPercent
from zepto
where mrp > 500 and discountPercent < 10
order by mrp desc, discountPercent desc

-- 5) Identify the top 5 categories offering the highest average discount percentage.
select category, ROUND(avg(discountPercent),2) as avg_discount
from zepto
group by category
order by avg_discount desc
limit 5; 

-- 6) Find the price per gram for products above 100g and sort by best value.
select distinct name , weightInGms , discountedSellingPrice,
ROUND(discountedSellingPrice/weightInGms,2) as price_per_gram
from zepto
where weightInGms> 100
order by price_per_gram;

--7) Group the product into categories like Low, Medium, Bulk.
select distinct name, weightInGms,
Case when weightInGms < 1000 then 'Low'
     when weightInGms < 5000 then 'Medium'
	 Else 'Bulk'
	 END as weight_category
	 from zepto;

-- 8) What is the Total Inventory Weight per Category
select category,
sum(weightInGms * availableQauntity) as total_weight
from zepto
group by category
order by total_weight;