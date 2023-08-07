-- bikeStore Queries

-- 1. Retrieve the first name and last name of all customers. 
select first_name,last_name from customers;
-- 2. Retrieve the products with a list price greater than $100.  
select * from products where list_price>100;
-- 3. Retrieve the staff members sorted by their last name in ascending order. 
select first_name,last_name from staffs order by last_name asc;
-- 4. Retrieve the order details with customer information (first name and last name) for each order.
select e.order_id, e.shipped_date,e.store_id,e.staff_id ,m.first_name,m.last_name
from orders e
inner join customers m on e.order_id=m.customer_id;
-- 5. Calculate the total quantity of each product sold.
 
SELECT brand_id, SUM(list_price) AS total_quantity_sold
FROM products
GROUP BY brand_id;




-- 6. Retrieve the products with a total quantity sold greater than 100.

SELECT brand_id, SUM(list_price) AS total_quantity_sold
FROM products
GROUP BY brand_id
HAVING SUM(list_price)> 1000;

-- 7. Retrieve the customers who have placed an order in the year 2016.
select customer_id from orders
where year(order_date)=2016;
-- 8. Insert a new category named "Electronics" into the categories table.
 alter table categories
 add Electronics varchar(100);
 select * from categories;

-- 9. Update the list price of a product with product_id = 1 to $150.
update products
set list_price=150 
 where product_id=1;
 select * from products;
-- 10. Delete the staff member with staff_id = 2 from the staffs table.
SET FOREIGN_KEY_CHECKS = 0;
-- SET FOREIGN_KEY_CHECKS = 1;

delete from staffs where staff_id=2 ;
select * from staffs;
-- 11. Retrieve the unique cities from the stores table.
select  distinct city from stores;

-- 12. Retrieve the products with a model year between 2016 and 2018.
select product_name,model_year from products
where model_year
between 2016 and 2018
-- 13. Retrieve the customers with an email address ending in "@gmail.com".
;
 SELECT * FROM customers WHERE email LIKE '%@gmail.com';


-- 14. Calculate the number of customers in the customers table.
select count(customer_id) from customers;
-- 15. Find the maximum and minimum list prices among all products.
select max(list_price) from products;
select min(list_price) from products;
-- 16. Calculate the total quantity and average list price of all products.
select sum(list_price),avg(list_price) from products;
-- 17. Retrieve the staff members who have placed at least one order.
 
 SELECT DISTINCT s.*
FROM staffs s
JOIN orders o ON s.staff_id = o.staff_id;

-- 18. Retrieve the orders placed by customers with IDs 1, 3, and 5.
 SELECT * FROM orders WHERE order_id IN (1, 3, 5);

-- 19. Retrieve the products with a NULL brand_id.
select * from products where   brand_id is null ;
-- 20. Combine the results of two SELECT statements to retrieve the names of staff members and customers.
select e.first_name,e.last_name
from staffs e
-- left join customers m on e.staff_id=m.customer_id/
union 
select m.first_name,m.last_name
from  customers m
-- right join  staffs e on e.staff_id=m.customer_id;

-- 21. Retrieve the order status as "Pending" for order_status = 1, "Processing" for order_status = 2, and "Completed" for order_status = 4.
;
 SELECT order_id,
  CASE
    WHEN order_status = 1 THEN 'Pending'
    WHEN order_status = 2 THEN 'Processing'
    WHEN order_status = 4 THEN 'Completed'
  END AS status
FROM orders;

-- 22. Retrieve the top 5 highest-priced products.
SELECT * FROM products
ORDER BY   list_price DESC
LIMIT 5;

-- 23. Retrieve the staff members along with the names of their managers.
SELECT s.staff_id, s.first_name AS staff_name, m.manager_id AS manager_name
FROM staffs s
INNER JOIN staffs m ON s.manager_id = m.staff_id;


-- 24. Retrieve all possible combinations of staff members and stores.
 select * from staffs,stores;
-- 25. Retrieve the products that have at least one order and products that have no orders.
SELECT *
FROM products
LEFT JOIN orders ON products.product_id = orders.order_id
WHERE orders.order_id IS NOT NULL -- Products with at least one order
or orders.order_id IS NULL -- Products with no orders


;
SELECT p.product_id, p.product_name
FROM products p
LEFT JOIN orders o ON p.product_id = o.order_id
WHERE o.order_id IS NOT NULL

UNION

SELECT p.product_id, p.product_name
FROM products p
LEFT JOIN orders o ON p.product_id = o.order_id
WHERE o.order_id IS NULL;

SELECT *
FROM products
WHERE product_id IN (
    SELECT DISTINCT order_id
    FROM orders
) OR product_id NOT IN (
    SELECT DISTINCT order_id
    FROM orders
);





-- 26. Retrieve the customers who have placed an order but have not registered as a staff member.

SELECT *
FROM customers
WHERE customer_id IN (
    SELECT order_id
    FROM orders
    WHERE order_id NOT IN (
        SELECT staff_id
        FROM staffs
    )
);


 SELECT *
FROM customers
WHERE customer_id IN (
    SELECT  order_id
    FROM orders
    WHERE  customer_id NOT IN (
        SELECT staff_id
        FROM staffs
    )
);





-- 27. Create a view named "top_customers" that retrieves the top 10 customers based on their total order amount.
CREATE VIEW top_customers AS
SELECT product_id, SUM(list_price) AS TotalOrderAmount
FROM products
GROUP BY product_id
ORDER BY TotalOrderAmount DESC
LIMIT 10;


-- 28. Add an index to the "email" column of the customers table.
 CREATE INDEX idx_customers_email ON customers (email);
 select * from customers;

-- 29. Create a trigger that automatically updates the total_quantity column in the stocks table when a new order is placed.
 CREATE TRIGGER update_total_quantity
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    UPDATE stocks
    SET total_quantity = total_quantity - NEW.quantity
    WHERE product_id = NEW.product_id
END






-- 30. Create a stored procedure named "get_order_details" that accepts an order ID as input and retrieves the order details.
;
CREATE PROCEDURE get_order_details(IN order_id INT)

    SELECT *
    FROM orders
    WHERE order_id = order_id

 
;
CALL get_order_details(123);


-- 31. Retrieve the product name and its corresponding brand name for all products.
 SELECT products.product_name, brands.brand_name
FROM products
JOIN brands ON products.brand_id = brands.brand_id;




-- 32. Calculate the total sales amount for each store.
SELECT stores.store_name, SUM(list_price) AS total_sales_amount
FROM products
JOIN stores ON products.brand_id = stores.store_id
GROUP BY stores.store_name;

-- 33. Retrieve the customer details (first name, last name, email) who have placed the maximum number of orders.
SELECT customers.first_name, customers.last_name, customers.email 
FROM customers
JOIN ( 
  SELECT customer_id, COUNT(*) AS order_count
  FROM orders
  GROUP BY customer_id
  HAVING COUNT(*) = (
    SELECT COUNT(*) AS max_order_count
    FROM orders
    GROUP BY customer_id
    ORDER BY max_order_count DESC
    LIMIT 1
  )
) AS subquery ON customers.customer_id = subquery.customer_id;



-- 34. Retrieve the staff members along with the names of their managers (including staff members without managers).

SELECT s.first_name AS staff_member, m.manager_id AS manager
FROM staffs s
LEFT JOIN staffs m ON s.manager_id = m.staff_id;




-- 35. Retrieve the total quantity of each product along with its corresponding category name.

SELECT products.product_name,  products.category_id, SUM(order_items.quantity) AS total_quantity
FROM products
JOIN  order_items ON products.product_id =  order_items.product_id
GROUP BY products.product_name,   products.category_id;









-- 36. Retrieve the hierarchical structure of staff members (managers and their subordinates).

WITH RECURSIVE StaffHierarchy AS (
  SELECT
    staff_id,
    manager_id,
    0 AS level
  FROM
    staffs
  WHERE
    manager_id IS NULL -- Assuming the top-level manager has a NULL manager_id
  UNION ALL
  SELECT
    s.staff_id,
    s.manager_id,
    sh.level + 1 AS level
  FROM
    staffs s
  INNER JOIN
    StaffHierarchy sh ON s.manager_id = sh.staff_id
)
SELECT
  staff_id,
  manager_id,
  level
FROM
  StaffHierarchy;



-- 37. Retrieve the order details along with the cumulative sales amount for each order.
select 
-- 38. Retrieve the products and their corresponding categories from different databases (production and sales).

-- 39. Retrieve the customers who have a phone number or email address.

-- 40. Retrieve the list of customers who have placed an order on a specific date: '2023-06-23'

-- 41. Find the total quantity and total sales amount for each product in a specific store:

-- 42. List the names of all active staff members along with their corresponding store names:

-- 43. Calculate the average discount given on orders placed in a specific store:

-- 44. Retrieve the order details (order ID, order date, customer name) for orders that are still pending:

-- 45. Retrieve the names of all the brands along with the total number of products each brand has.

-- 46. Retrieve the top 5 customers who have spent the highest total amount on their orders.

-- 47. Retrieve the orders that are pending and have not been shipped yet.

-- 48. Retrieve the total quantity of each product available in the stocks.

-- 49. Retrieve the names of the staff members along with the count of orders assigned to them.

-- 50. Retrieve the list of products with their corresponding categories and brands.

-- 51. Retrieve the customers who have placed at least one order in the year 2022.

-- 52. Retrieve the staff members who are currently active and working in a specific store.

-- 53. Retrieve the order details along with the customer's name and the store's name for a specific order ID.

-- 54. Create Stored Procedure - Retrieve Orders by Customer ID:

-- 55. Create Stored Procedure - Insert New Customer:

-- 56. Create Stored Function - Calculate Total Order Amount for a Customer:

-- 57. Create Stored Function - Get Product Count by Category:



