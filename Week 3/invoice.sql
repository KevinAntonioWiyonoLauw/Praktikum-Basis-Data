-- Active: 1754133432363@@localhost@3306
-- Active: 1757838666175@@localhost@3307@praktikum_db
CREATE DATABASE IF NOT EXISTS InvoiceDB;

USE InvoiceDB;

CREATE TABLE IF NOT EXISTS Customers (
    customer_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(255),
    credit_limit DECIMAL(10, 2) NOT NULL 
);

CREATE TABLE IF NOT EXISTS Products (
    product_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    description VARCHAR(255) NOT NULL,
    finish VARCHAR(255) NOT NULL,
    quantity_in_stock INT NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL
);

CREATE TABLE IF NOT EXISTS Orders (
    order_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE IF NOT EXISTS OrderDetails (
    order_detail_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    extended_price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- ...existing code...

-- 1. INSERT OPERATIONS

-- a. Customer PT Maju Jaya sudah ada
INSERT INTO Customers (name, address, credit_limit) VALUES
("PT Maju Jaya", "Jakarta", 100000000);

-- b. Tambahkan produk baru (menyesuaikan dengan struktur tabel Products)
INSERT INTO Products (product_id, description, finish, quantity_in_stock, unit_price) VALUES
(99999, "Kursi Kayu Jati", "Natural Jati", 50, 1200000);

-- c. Buat order baru untuk PT Maju Jaya dengan 2 item produk
-- Ambil customer_id untuk PT Maju Jaya
INSERT INTO Orders (customer_id, order_date, total_amount) VALUES
(1, CURDATE(), 12000000); -- Akan di-update setelah detail

-- Tambahkan detail order (misal produk ID 7 dan 99999, masing-masing 5 unit)
INSERT INTO OrderDetails (order_id, product_id, quantity, unit_price, extended_price) VALUES
(1, 7, 5, 800000, 4000000),    -- 5 unit Dining Table
(1, 99999, 5, 1200000, 6000000); -- 5 unit Kursi Kayu Jati

-- Update total amount di Orders
UPDATE Orders SET total_amount = 10000000 WHERE order_id = 1;

-- 2. UPDATE OPERATIONS

-- a. Perbarui creditLimit customer "PT Maju Jaya"
UPDATE Customers 
SET credit_limit = 150000000 
WHERE name = "PT Maju Jaya";

-- b. Ubah status order (kolom status tidak ada, skip atau tambah kolom dulu)
-- ALTER TABLE Orders ADD COLUMN status VARCHAR(50) DEFAULT 'In Process';
-- UPDATE Orders SET status = 'Shipped' WHERE order_id = 1;

-- c. Naikkan unit_price produk tertentu sebesar 10% (misal kategori tertentu)
UPDATE Products 
SET unit_price = unit_price * 1.1 
WHERE finish LIKE '%Natural%'; -- Contoh kategori berdasarkan finish

-- 3. DELETE OPERATIONS

-- a. Hapus produk yang tidak pernah ada di OrderDetails
DELETE FROM Products 
WHERE product_id NOT IN (SELECT DISTINCT product_id FROM OrderDetails);

-- b. Hapus customer yang belum pernah melakukan transaksi
DELETE FROM Customers 
WHERE customer_id NOT IN (SELECT DISTINCT customer_id FROM Orders);

-- 4. SELECT (untuk verifikasi)

-- a. Tampilkan daftar order dari customer "PT Maju Jaya"
SELECT o.order_id, o.order_date, o.total_amount, c.name as customer_name
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
WHERE c.name = "PT Maju Jaya";

-- b. Tampilkan semua produk dengan harga jual di atas Rp 1.000.000
SELECT product_id, description, finish, unit_price, quantity_in_stock
FROM Products 
WHERE unit_price > 1000000;

-- Query tambahan untuk melihat detail order
SELECT od.order_id, p.description, p.finish, od.quantity, od.unit_price, od.extended_price
FROM OrderDetails od
JOIN Products p ON od.product_id = p.product_id
JOIN Orders o ON od.order_id = o.order_id
JOIN Customers c ON o.customer_id = c.customer_id
WHERE c.name = "PT Maju Jaya";