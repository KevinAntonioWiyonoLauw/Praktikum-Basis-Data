/* 
Menggunakan database classicmodel, kerjakan latihan berikut :
1. DISTINCT
Tampilkan daftar negara (country) tempat customer berasal, tanpa duplikasi.
2. WHERE + ORDER BY
Tampilkan 10 customer dari USA dengan creditLimit di atas 50.000, urutkan
berdasarkan creditLimit terbesar.
3. LIMIT
Ambil 5 produk dengan harga jual (MSRP) tertinggi.
4. AND / OR
Tampilkan data customer dari kota Paris ATAU Madrid, dengan creditLimit
lebih dari 80.000.
5. IN
Tampilkan daftar customer yang berasal dari negara berikut: USA, France,
Japan.
6. BETWEEN
Tampilkan produk dengan harga beli (buyPrice) antara 50 dan 100.
7. LIKE
Tampilkan semua produk yang nama produknya mengandung kata “Ford”.
8. IS NULL
Tampilkan semua order yang belum memiliki tanggal pengiriman
(shippedDate).
*/

USE classicmodels;

-- 1. DISTINCT
SELECT DISTINCT country FROM customers;

-- 2. WHERE + ORDER BY
SELECT * FROM customers 
WHERE country = 'USA' AND creditLimit > 50000
ORDER BY creditLimit DESC
LIMIT 10;

-- 3. LIMIT
SELECT * FROM products
ORDER BY MSRP DESC
LIMIT 5;

-- 4. AND / OR
SELECT * FROM customers
WHERE (city = 'Paris' OR city = 'Madrid') AND creditLimit > 80000;

-- 5. IN
SELECT * FROM customers
WHERE country IN ('USA', 'France', 'Japan');

-- 6. BETWEEN
SELECT * FROM products
WHERE buyPrice BETWEEN 50 AND 100;

-- 7. LIKE
SELECT * FROM products
WHERE productName LIKE '%Ford%';

-- 8. IS NULL
SELECT * FROM orders
WHERE shippedDate IS NULL;