SELECT * FROM salesdata_sales_datatableau.sales_data;
Use salesdata_tableau;

-- Storing only unique values
Select distinct status from sales_data;
Select distinct year_id from sales_data;
Select distinct month_id from sales_data;
Select distinct productline from sales_data;
Select distinct country from sales_data;
select Territory from sales_data;

-- Sorting by product line
-- Question: How much total sale for every product listed in table
Select year_id, productline, Round(sum(sales),3)  as Revenue from sales_data
group by PRODUCTLINE
order by sum(sales) desc;

-- How much total sale for each year
select year_id, round(sum(sales),3) as Revenue from sales_data
group by year_id
order by round(sum(sales),3) desc;

-- Year 2005 has lowest sale. Lets find out why: 
Select distinct month_id from sales_data
where year_id = 2003;

-- 2005 operated for 5 months
-- 2003 & 2004 operated for 12 months

-- Analyse the sales by deal size
Select Dealsize, round(sum(sales), 3) from sales_data
group by dealsize
order by round(sum(sales), 3)  desc;
-- Medium deal size generates the more revenue. so lets focus on that. 

-- what was the best month for sales, in specific year with how much of sales?
select month_id, Round(sum(sales),3) as Revenue, count(ordernumber) as Total_number_of_order 
from sales_data
where year_id = 2004
group by month_id
order by Round(sum(sales),3) desc;

-- for year 2003 & 2004, month 11 generated max sales
-- for year 2005, month 5 generated the max sales

-- What product in November (11th month) is being sold max
select month_id, productline, sum(sales), count(ordernumber) from sales_data
where year_id = 2005 && month_id = 5
group by PRODUCTLINE
order by sum(sales) desc;

-- who is the best customer (Recency-Frequency-Monetory Analysis used for segmenting the customers) 
-- Recency (last order date gap from the latest order date in the database)
-- Frequency ( count of total orders)
-- Monetory value (total spend)


create table rfm
with rfm_a as 
(
Select customername, round(sum(sales),3) as Monetory, Round(avg(sales),3) as AvgSalesPerCustomer, 
((Select max(orderdate) from sales_data)- (max(orderdate))) as recency, count(ordernumber) as Frequency
from sales_data
group by customername
), 
rfm_b as 
( select rfm_a.*,
ntile(4) over(order by recency) as rfm_recency, 
ntile(4) over(order by Monetory) AS rfm_monetory, 
ntile(4) over(order by Frequency) as rfm_frequency
from rfm_a
)
select rfm_b.*, 
 (rfm_recency+ rfm_monetory+rfm_frequency) as rfm_total, 
 concat(rfm_recency, rfm_monetory, rfm_frequency) as rfm_string
 from rfm_b;

select rfm.*,
case
when rfm_string in (111, 112 , 121, 122, 123, 132, 211, 212, 114, 141) then 'lost customers'  
		when rfm_string in (133, 134, 143, 244, 334, 343, 344, 144) then 'potential cutomers but loosing them' 
		when rfm_string in (311, 411, 331) then 'new customers'
		when rfm_string in (222, 223, 233, 322) then 'potential customers'
		when rfm_string in (323, 333,321, 422, 332, 432) then 'active customers'
		when rfm_string in (433, 434, 443, 444) then 'loyal customers'
        end 
        as rfm_segment
 from rfm;


-- what 3 products are most often sold together
with mkm as (
	select ordernumber, productcode from sales_data 
		where ORDERNUMBER in 
		   (
			select ordernumber  
			from 
				(select ordernumber, count(*) as count_order from  sales_data
				where status = 'Shipped'
				group by ORDERNUMBER) as m 
			where count_order = 3
			) 
            order by ordernumber asc)
select ordernumber, group_concat(productcode) from mkm group by ordernumber;
            
            
-- which city is generating max revenue 
select city, sum(sales) as revenue from sales_data 
group by city
order by sum(sales) desc; 

-- What is the 2 best product in Denmark?
select PRODUCTCODE, sum(sales) as revenue from sales_data
where country = 'denmark'
group by PRODUCTCODE
order by sum(sales) desc
limit 2