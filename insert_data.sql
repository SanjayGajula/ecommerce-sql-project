INSERT INTO customers (name, email, city, created_at) VALUES
('Rahul', 'rahul@gmail.com', 'Hyderabad', '2024-01-10'),
('Anjali', 'anjali@gmail.com', 'Bangalore', '2024-02-15'),
('Kiran', 'kiran@gmail.com', 'Chennai', '2024-03-01');

INSERT INTO products (product_name, category, price) VALUES
('Laptop', 'Electronics', 60000),
('Mobile', 'Electronics', 30000),
('Headphones', 'Accessories', 2000);

INSERT INTO orders (customer_id, order_date) VALUES
(1, '2024-04-01'),
(2, '2024-04-05'),
(1, '2024-04-10');

INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1, 1, 1),
(1, 3, 2),
(2, 2, 1),
(3, 3, 1);

INSERT INTO payments (order_id, payment_method, payment_status) VALUES
(1, 'UPI', 'Completed'),
(2, 'Credit Card', 'Completed'),
(3, 'Cash', 'Pending');
