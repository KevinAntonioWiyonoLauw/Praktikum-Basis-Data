-- Active: 1758272946900@@127.0.0.1@3307@shopsmart
-- =========================================================
-- 1) Siapkan database
-- =========================================================
DROP DATABASE IF EXISTS shopsmart;
CREATE DATABASE shopsmart;
USE shopsmart;

-- =========================================================
-- 2) Tabel inti
-- =========================================================

-- Customers
DROP TABLE IF EXISTS Customers;
CREATE TABLE Customers (
  customer_id   INT AUTO_INCREMENT PRIMARY KEY,
  name          VARCHAR(100) NOT NULL,
  email         VARCHAR(150) NOT NULL UNIQUE,
  phone         VARCHAR(30),
  address       VARCHAR(255),
  created_at    DATE NOT NULL
) ENGINE=InnoDB;

-- Categories
DROP TABLE IF EXISTS Categories;
CREATE TABLE Categories (
  category_id   INT AUTO_INCREMENT PRIMARY KEY,
  category_name VARCHAR(100) NOT NULL UNIQUE
) ENGINE=InnoDB;

-- Products
DROP TABLE IF EXISTS Products;
CREATE TABLE Products (
  product_id      INT AUTO_INCREMENT PRIMARY KEY,
  name            VARCHAR(150) NOT NULL,
  description     TEXT,
  price           DECIMAL(10,2) NOT NULL,
  stock_quantity  INT NOT NULL DEFAULT 0,
  category_id     INT NOT NULL,
  CONSTRAINT fk_products_category
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

-- Orders (gunakan nama "Orders", bukan "Order" karena ORDER itu keyword)
DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders (
  order_id      INT PRIMARY KEY,
  customer_id   INT NOT NULL,
  order_date    DATE NOT NULL,
  total_amount  DECIMAL(12,2) NOT NULL,
  status        VARCHAR(30) NOT NULL,
  CONSTRAINT fk_orders_customer
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

-- Order_Details
DROP TABLE IF EXISTS Order_Details;
CREATE TABLE Order_Details (
  order_id     INT NOT NULL,
  product_id   INT NOT NULL,
  quantity     INT NOT NULL,
  unit_price   DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (order_id, product_id),
  CONSTRAINT fk_od_order
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_od_product
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

-- Payments
DROP TABLE IF EXISTS Payments;
CREATE TABLE Payments (
  payment_id      INT AUTO_INCREMENT PRIMARY KEY,
  order_id        INT NOT NULL,
  payment_date    DATE NOT NULL,
  amount          DECIMAL(12,2) NOT NULL,
  payment_method  VARCHAR(50) NOT NULL,
  CONSTRAINT fk_pay_order
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
    ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

-- Reviews
DROP TABLE IF EXISTS Reviews;
CREATE TABLE Reviews (
  review_id    INT AUTO_INCREMENT PRIMARY KEY,
  customer_id  INT NOT NULL,
  product_id   INT NOT NULL,
  rating       INT NOT NULL,          -- 1..5
  review_text  TEXT,
  review_date  DATE NOT NULL,
  CONSTRAINT fk_rev_customer
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_rev_product
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
    ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

-- =========================================================
-- 3) INSERT contoh data
-- =========================================================

-- Categories
INSERT INTO Categories (category_name) VALUES
  ('Electronics'), ('Fashion'), ('Home & Living');

-- Products
INSERT INTO Products (name, description, price, stock_quantity, category_id) VALUES
('Wireless Headphones', 'BT 5.3, 30h battery life', 79.99, 50, 1),
('Smartphone Case',      'Shockproof TPU',          19.99, 150, 1),
('Running Shoes',        'Lightweight, breathable', 59.95, 80, 2),
('Coffee Maker',         'Drip 1.2L',               89.00, 20, 3),
('LED Desk Lamp',        'Adjustable brightness',   25.50, 100, 3),
('Denim Jacket',         'Classic fit',             69.00, 40, 2),
('Varsity Jacket',         'Classic fit',             69.00, 40, 2);

-- Customers
INSERT INTO Customers (name, email, phone, address, created_at) VALUES
('Alice Johnson', 'alice@example.com', '0811-111-111', 'Jl. Merpati 1, Jakarta', '2019-06-15'),
('Bob Smith',     'bob@example.com',   '0812-222-222', 'Jl. Kenari 5, Bandung',  '2021-02-10'),
('Carol Lee',     'carol@example.com', '0821-333-333', 'Jl. Jati 7, Surabaya',   '2023-08-01'),
('Dan Brown',     'dan@example.com',   '0822-444-444', 'Jl. Anggrek 2, Depok',   '2020-11-20'),
('Eva Green',     'eva@example.com',   '0838-555-555', 'Jl. Flamboyan 9, Yogya', '2018-03-05');

-- Orders
INSERT INTO Orders (order_id, customer_id, order_date, total_amount, status) VALUES
(1001, 1, '2024-11-10',  99.98, 'Completed'),
(1002, 2, '2024-11-12', 128.95, 'Completed'),
(1003, 1, '2024-12-01', 114.50, 'Completed'),
(1004, 3, '2025-01-05',  25.50, 'Pending'),
(1005, 4, '2025-01-20', 139.94, 'Completed');

-- Order_Details
INSERT INTO Order_Details (order_id, product_id, quantity, unit_price) VALUES
-- Order 1001: Alice -> Headphones + Case
(1001, 1, 1, 79.99),
(1001, 2, 1, 19.99),

-- Order 1002: Bob -> Running Shoes + Denim Jacket
(1002, 3, 1, 59.95),
(1002, 6, 1, 69.00),

-- Order 1003: Alice -> Coffee Maker + Desk Lamp
(1003, 4, 1, 89.00),
(1003, 5, 1, 25.50),

-- Order 1004: Carol -> Desk Lamp
(1004, 5, 1, 25.50),

-- Order 1005: Dan -> Headphones + Running Shoes
(1005, 1, 1, 79.99),
(1005, 3, 1, 59.95);

-- Payments
INSERT INTO Payments (order_id, payment_date, amount, payment_method) VALUES
(1001, '2024-11-10',  99.98, 'Credit Card'),
(1002, '2024-11-12', 128.95, 'Bank Transfer'),
(1003, '2024-12-01', 114.50, 'E-Wallet'),
(1004, '2025-01-05',  25.50, 'Cash'),
(1005, '2025-01-20', 139.94, 'Credit Card');

-- Reviews
INSERT INTO Reviews (customer_id, product_id, rating, review_text, review_date) VALUES
(1, 1, 5, 'Great sound!',               '2024-11-15'),
(2, 1, 4, 'Comfortable to wear',        '2024-11-18'),
(2, 3, 5, 'Perfect for running',        '2024-11-20'),
(4, 3, 4, 'Good grip, comfy',           '2025-01-25'),
(3, 2, 3, 'Decent case for the price',  '2025-01-07'),
(1, 4, 4, 'Brews fast, tastes good',    '2024-12-05');


-- total number of orders placed by each customers
SELECT
    c.name AS customerName,
    COUNT(o.order_id) AS totalOrders
FROM 
    Customers c
LEFT JOIN Orders o ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.name;

-- product with stock < 10
SELECT
    p.name AS productName,
    p.stock_quantity AS quantity
FROM
    Products p
WHERE p.stock_quantity < 30;

-- products that have never been ordered by any customer
SELECT 
    p.product_id,
    p.name AS productName,
    p.price,
    p.stock_quantity
FROM 
    Products p
LEFT JOIN Order_Details od ON od.product_id = p.product_id
WHERE 
    od.product_id IS NULL;

-- total payment received based on payment method
SELECT
    p.payment_method,
    SUM(p.amount) AS total_payment
FROM 
    Payments p
GROUP BY p.payment_method;

-- customers who have placed more than 5 orders
SELECT 
    c.name,
    COUNT(o.order_id) AS total_order
FROM
    Customers c
JOIN Orders o ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.name
HAVING COUNT(o.order_id) > 1; 

-- products that have never been reviewed by customers
SELECT
    p.product_id,
    p.name
FROM
    Products p
LEFT JOIN Reviews r ON r.product_id = p.product_id
WHERE r.product_id IS NULL;

-- customers who have purchase all products in the "Electronics" category
SELECT 
    c.customer_id,
    c.name AS customerName
FROM 
    Customers c
    JOIN Orders o ON c.customer_id = o.customer_id
    JOIN Order_Details od ON o.order_id = od.order_id
    JOIN Products p ON od.product_id = p.product_id
    JOIN Categories cat ON p.category_id = cat.category_id
WHERE 
    cat.category_name = 'Electronics'
GROUP BY 
    c.customer_id, c.name
HAVING 
    COUNT(DISTINCT od.product_id) = 2;

-- products that have never been purchased by customers who joined before 2020
SELECT 
    p.product_id,
    p.name AS productName,
    p.price
FROM 
    Products p
WHERE 
    p.product_id NOT IN (
        SELECT DISTINCT od.product_id
        FROM Order_Details od
        JOIN Orders o ON od.order_id = o.order_id
        JOIN Customers c ON o.customer_id = c.customer_id
        WHERE c.created_at < '2020-01-01'
        AND od.product_id IS NOT NULL
    );

-- customers name and total ammount they have spent on all orders
SELECT
    c.name,
    SUM(o.total_amount) AS total_payments
FROM
    Customers c
LEFT JOIN Orders o ON o.customer_id = c.customer_id
WHERE o.status = 'Completed'
GROUP BY c.customer_id;

-- list of products with category and the total of orders of each products
SELECT 
    p.name AS productName, 
    c.category_name,
    COUNT(od.order_id) AS totalOrders
FROM 
    Products p
LEFT JOIN Categories c ON p.category_id = c.category_id
LEFT JOIN Order_Details od ON od.product_id = p.product_id
GROUP BY p.product_id, p.name, c.category_name;

-- products with highest rating and atleast 5 reviews
SELECT 
    p.name,
    AVG(r.rating)
FROM
    Products p
LEFT JOIN Reviews r ON p.product_id = r.product_id
GROUP BY p.product_id, p.name
HAVING COUNT(r.product_id) > 1
ORDER BY AVG(r.rating) DESC
LIMIT 1;

-- total sales (in monetary value) generated by each product category
SELECT
    c.category_name,
    SUM(od.quantity * od.unit_price)
FROM
    Categories c
LEFT JOIN Products p ON p.category_id = c.category_id
LEFT JOIN Order_Details od ON od.product_id = p.product_id
GROUP BY c.category_name;

-- customers who paid more than avg payment amount across all orders
SELECT
    c.name,
    p.amount
FROM
    Customers c
LEFT JOIN Orders o ON o.customer_id = c.customer_id 
LEFT JOIN Payments p ON p.order_id = o.order_id
WHERE 
    p.amount > (
        SELECT AVG(amount) 
        FROM Payments
    );