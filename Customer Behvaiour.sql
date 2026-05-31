create database customer_behavior;
SELECT USER();
SELECT user, host FROM mysql.user;
USE customer_behavior;
SHOW TABLES;
select * from customer;
SELECT gender, 
    SUM(`purchase_amount_(usd)`) AS revenue
FROM customer
GROUP BY gender;
RENAME TABLE customer_data TO customer;
SELECT 
    customer_id, 
    `purchase_amount`
FROM 
    customer
WHERE 
    discount_applied = 'Yes' 
    AND `purchase_amount` >= (SELECT AVG(`purchase_amount`) FROM customer);
select purchase_amount
from customer;
select item_purchased,avg(review_rating) as "avarage product rating"
from customer
group by item_purchased
order by avg(review_rating)desc
limit 5;
select shipping_type,round(avg(purchase_amount),2)
from customer
where shipping_type in ('standard','express')
group by shipping_type;
WITH item_counts AS (
    SELECT 
        category,
        item_purchased,
        COUNT(customer_id) AS total_order,
        ROW_NUMBER() OVER(PARTITION BY category ORDER BY COUNT(customer_id) DESC) AS item_rank
    FROM 
        customer
    GROUP BY 
        category, item_purchased
)
SELECT 
    item_rank, 
    category, 
    item_purchased, 
    total_order
FROM 
    item_counts
WHERE 
    item_rank <= 3;
