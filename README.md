# Sales-Data-analysis-with-SQL-Tableau

In this repository, you will find the analysis of Sales data consisting of customer, Product and Revenue data from 2003-2005.
* This analysis has been done using MySQL and further a visualization dashboard has been made using Tableau. 

So, what questions I derived and what techniques i used for the analysis? 
1. What are the columns which contributes more to the analysis? 
* Type of product
* Sales
* Order date
* Country
* Customer details
2. What is the total/avg sale of each year? Does it depends on any particular season/month?
3. What is the best month as per the revenue? Which product contributes maximum to the sale?  
4. Find out the sets of customers which are more frequent and more valuable to us? 
* I used the RFM(Recency, Frequency, Monetary) technique to sort out the customers based upon their: 
>> * Gap between current and last purchase date - Recency
>> * Count of total orders by each customer - Frequency
>> * Total amount spent by them - Monetory 
>> This devides the customer into category of *"Lost customers, potential but company lossing them, new customers, potentisl, active and loyal cutomers"*

5. Which 3 products are maximum sold together? 


*Afterwards, I moved on to the tableau, made a dashboard using parameters like, Sum of sales, dealsize, country, customer, product etc. 
Youu can check out the dashboard on https://public.tableau.com/views/Salesdatadashboard_16688557981090/SalesDash2?:language=en-US&:display_count=n&:origin=viz_share_link*
