-- Active: 1757838666175@@localhost@3307@classicmodels
USE classicmodels;

-- Tampilkan daftar transaksi lengkap berisi nama pelanggan, tanggal transaksi, dan nama produk yang dibeli.
SELECT 
    c.customerName AS NamaPelanggan,
    o.orderDate AS TanggalTransaksi,
    p.productName AS NamaProduk
FROM orders o
INNER JOIN customers c ON o.customerNumber = c.customerNumber
INNER JOIN orderdetails od ON o.orderNumber = od.orderNumber
INNER JOIN products p ON od.productCode = p.productCode
ORDER BY o.orderDate DESC, c.customerName
LIMIT 20;


-- Tampilkan semua pelanggan, termasuk pelanggan yang belum pernah melakukan transaksi.
SELECT 
    c.customerNumber,
    c.customerName,
    c.city,
    c.country,
    COUNT(o.orderNumber) AS JumlahOrder,
    SUM(od.quantityOrdered * od.priceEach) AS TotalBelanja
FROM customers c
LEFT JOIN orders o ON c.customerNumber = o.customerNumber
LEFT JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY c.customerNumber, c.customerName, c.city, c.country
ORDER BY JumlahOrder DESC, c.customerName;


-- Tampilkan semua produk, termasuk produk yang belum pernah terjual.
SELECT 
    p.productCode,
    p.productName,
    p.productLine,
    p.quantityInStock,
    SUM(od.quantityOrdered) AS TotalTerjual,
    COUNT(DISTINCT od.orderNumber) AS JumlahOrder
FROM orderdetails od
RIGHT JOIN products p ON od.productCode = p.productCode
GROUP BY p.productCode, p.productName, p.productLine, p.quantityInStock
ORDER BY TotalTerjual DESC;

-- Dari tabel Produk, tampilkan pasangan produk yang harganya sama (kecuali dirinya sendiri).
SELECT 
    p1.productCode AS KodeProduk1,
    p1.productName AS NamaProduk1,
    p2.productCode AS KodeProduk2,
    p2.productName AS NamaProduk2,
    p1.buyPrice AS Harga
FROM 
    products p1
JOIN 
    products p2 
    ON p1.buyPrice = p2.buyPrice 
    AND p1.productCode < p2.productCode
ORDER BY 
    p1.buyPrice, p1.productCode, p2.productCode;


-- Gabungkan daftar semua nama pelanggan dan semua nama supplier ke dalam satu hasil query.
SELECT customerName AS Nama, 'Pelanggan' AS Tipe
FROM customers
UNION
SELECT CONCAT(firstName, ' ', lastName) AS Nama, 'Karyawan' AS Tipe
FROM employees
ORDER BY Nama;