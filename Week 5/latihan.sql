USE classicmodels;

-- SOAL NO 1: Tampilkan nilai kredit terbesar (creditLimit) dari seluruh customer.
SELECT MAX(creditLimit) FROM customers;

-- SOAL NO 2: Tampilkan tanggal order paling awal yang tercatat di tabel orders.
SELECT MIN(orderDate) FROM orders;

-- SOAL NO 3: Hitung rata-rata harga beli (buyPrice) produk dalam kategori Classic Cars.
SELECT AVG(buyPrice) FROM products WHERE productLine = 'Classic Cars';

-- SOAL NO 4: Hitung total penjualan (quantityOrdered × priceEach) dari tabel orderdetails.
SELECT SUM(quantityOrdered * priceEach) FROM orderdetails;

-- SOAL NO 5: Hitung jumlah customer dari negara USA.
SELECT COUNT(*) FROM customers WHERE country = 'USA';

-- SOAL NO 6: Tampilkan jumlah customer per negara (country).
SELECT country, COUNT(*) FROM customers GROUP BY country;

-- SOAL NO 7: Hitung total nilai penjualan untuk setiap produk (group berdasarkan productCode).
SELECT productCode, SUM(quantityOrdered * priceEach) AS totalHarga 
FROM orderdetails 
GROUP BY productCode;

-- SOAL NO 8: Tampilkan daftar productLine yang memiliki rata-rata harga jual (MSRP) di atas 80.
SELECT productLine, AVG(MSRP) AS rataMSRP 
FROM products 
GROUP BY productLine 
HAVING rataMSRP > 80;

-- SOAL NO 9: Tampilkan daftar negara yang memiliki lebih dari 10 customer.
SELECT country, COUNT(*) AS banyakCustomer 
FROM customers 
GROUP BY country 
HAVING banyakCustomer > 10;

-- SOAL NO 10: Hitung total penjualan per orderNumber, lalu tampilkan hanya order dengan total penjualan di atas 50.000.
SELECT orderNumber, SUM(quantityOrdered * priceEach) AS totalPenjualan 
FROM orderdetails 
GROUP BY orderNumber 
HAVING totalPenjualan > 50000;