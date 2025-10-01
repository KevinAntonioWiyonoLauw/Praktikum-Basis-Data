-- Active: 1758272946900@@127.0.0.1@3307@classicmodels
USE classicmodels;

-- Tampilkan daftar transaksi lengkap berisi nama pelanggan, tanggal transaksi, dan nama produk yang dibeli.
SELECT 
    c.customerName AS NamaPelanggan,
    o.orderDate AS TanggalTransaksi,
    p.productName AS NamaProduk,
    od.quantityOrdered AS Jumlah,
    od.priceEach AS HargaSatuan
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
    COALESCE(SUM(od.quantityOrdered * od.priceEach), 0) AS TotalBelanja
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
    COALESCE(SUM(od.quantityOrdered), 0) AS TotalTerjual,
    COALESCE(COUNT(DISTINCT od.orderNumber), 0) AS JumlahOrder
FROM orderdetails od
RIGHT JOIN products p ON od.productCode = p.productCode
GROUP BY p.productCode, p.productName, p.productLine, p.quantityInStock
ORDER BY TotalTerjual DESC;

-- Dari tabel Produk, tampilkan pasangan produk yang harganya sama (kecuali dirinya sendiri).
SELECT 
    p1.productCode AS Produk1_Code,
    p1.productName AS Produk1_Nama,
    p2.productCode AS Produk2_Code,
    p2.productName AS Produk2_Nama,
    p1.buyPrice AS HargaBeli,
    p1.MSRP AS HargaJual
FROM products p1
INNER JOIN products p2 
    ON p1.buyPrice = p2.buyPrice 
    AND p1.MSRP = p2.MSRP
    AND p1.productCode < p2.productCode
ORDER BY p1.buyPrice DESC, p1.productName;


-- Gabungkan daftar semua nama pelanggan dan semua nama supplier ke dalam satu hasil query.
SELECT customerName AS Nama, 'Pelanggan' AS Tipe
FROM customers
UNION
SELECT CONCAT(firstName, ' ', lastName) AS Nama, 'Karyawan' AS Tipe
FROM employees
ORDER BY Nama;