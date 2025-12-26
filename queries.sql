-- =========================================
-- E-COMMERCE SALES DATABASE QUERIES
-- =========================================


-- Query 1: List all customers
SELECT * 
FROM customers;


-- Query 2: List all products
SELECT * 
FROM products;


-- Query 3: Total number of orders placed by each customer
SELECT c.name, COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.name;


-- Query 4: Customers who placed more than one order
SELECT c.name
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.name
HAVING COUNT(o.order_id) > 1;


-- Query 5: Total revenue generated from all orders
SELECT SUM(p.price * oi.quantity) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id;


-- Query 6: Total sales quantity for each product
SELECT p.product_name, SUM(oi.quantity) AS total_quantity_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name;


-- Query 7: Top-selling products based on quantity sold
SELECT p.product_name, SUM(oi.quantity) AS total_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC;


-- Query 8: Monthly revenue report
SELECT 
    MONTH(o.order_date) AS order_month,
    SUM(p.price * oi.quantity) AS monthly_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY MONTH(o.order_date)
ORDER BY order_month;


-- Query 9: Orders with pending payment status
SELECT o.order_id, py.payment_status
FROM orders o
JOIN payments py ON o.order_id = py.order_id
WHERE py.payment_status = 'Pending';


-- Query 10: Payment method usage count
SELECT payment_method, COUNT(payment_id) AS total_payments
FROM payments
GROUP BY payment_method;


-- Query 11: Customers who have never placed an order
SELECT name
FROM customers
WHERE customer_id NOT IN (
    SELECT customer_id FROM orders
);


-- Query 12: Average order value
SELECT AVG(order_total) AS average_order_value
FROM (
    SELECT o.order_id, SUM(p.price * oi.quantity) AS order_total
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN products p ON oi.product_id = p.product_id
    GROUP BY o.order_id
) subquery;


-- Query 13: Total spending by each customer
SELECT c.name, SUM(p.price * oi.quantity) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY c.name;


-- Query 14: Rank customers based on total spending (Window Function)
SELECT 
    c.name,
    SUM(p.price * oi.quantity) AS total_spent,
    RANK() OVER (ORDER BY SUM(p.price * oi.quantity) DESC) AS spending_rank
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY c.name;


-- Query 15: Highest priced product in each category
SELECT category, product_name, price
FROM products p1
WHERE price = (
    SELECT MAX(price)
    FROM products p2
    WHERE p1.category = p2.category
);
