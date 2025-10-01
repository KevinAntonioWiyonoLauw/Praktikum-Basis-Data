CREATE DATABASE IF NOT EXISTS aktivitasmahasiswa43;
USE aktivitasmahasiswa43;

CREATE TABLE IF NOT EXISTS student(
    id INT AUTO_INCREMENT PRIMARY KEY,
    nim VARCHAR(5) NOT NULL,
    name VARCHAR(100) NOT NULL,
    city_address VARCHAR(255) NOT NULL,
    age INT NOT NULL,
    IPK DECIMAL(3, 2) NOT NULL,
    departement VARCHAR(100)
);

INSERT INTO student (NIM, name, city_address, age, IPK, departement) VALUES
(12345, 'Adi', 'Jakarta', 17, 2.5, 'Math'),
(12346, 'Ani', 'Yogyakarta', 20, 2.1, 'Math'),
(12347, 'Ari', 'Surabaya', 18, 2.5, 'Computer'),
(12348, 'Ali', 'Banjarmasin', 20, 3.5, 'Computer'),
(12349, 'Abi', 'Medan', 17, 3.7, 'Computer'),
(12350, 'Budi', 'Jakarta', 19, 3.8, 'Computer'),
(12351, 'Boni', 'Yogyakarta', 20, 3.2, 'Computer'),
(12352, 'Bobi', 'Surabaya', 17, 2.7, 'Computer'),
(12353, 'Beni', 'Banjarmasin', 18, 2.3, 'Computer'),
(12354, 'Cepi', 'Jakarta', 20, 2.2, NULL),
(12355, 'Coni', 'Yogyakarta', 22, 2.6, NULL),
(12356, 'Ceki', 'Surabaya', 21, 2.5, 'Math'),
(12357, 'Dodi', 'Jakarta', 20, 3.1, 'Math'),
(12358, 'Didi', 'Yogyakarta', 19, 3.2, 'Physics'),
(12359, 'Deri', 'Surabaya', 19, 3.3, 'Physics'),
(12360, 'Eli', 'Jakarta', 20, 2.9, 'Physics'),
(12361, 'Endah', 'Yogyakarta', 18, 2.8, 'Physics'),
(12362, 'Feni', 'Jakarta', 17, 2.7, NULL),
(12363, 'Farah', 'Yogyakarta', 18, 3.5, NULL),
(12364, 'Fandi', 'Surabaya', 19, 3.4, NULL);

-- ================================================================
-- SOAL NO 2: DISTINCT
-- Tampilkan kolom city address tanpa ada duplikat.
-- ================================================================
SELECT DISTINCT city_address FROM student;

-- ================================================================
-- SOAL NO 3: MAX
-- Tampilkan nilai IPK Maksimum IPK dari mahasiswa dari Jakarta.
-- ================================================================
SELECT MAX(ipk) FROM student WHERE city_address = 'Jakarta';

-- ================================================================
-- SOAL NO 4: MIN
-- Tampilkan nilai IPK Minimum dari mahasiswa departemen Komputer.
-- ================================================================
SELECT MIN(ipk) FROM student WHERE departement = 'Computer';

-- ================================================================
-- SOAL NO 5: AVG
-- Tampilkan nilai IPK Rata-rata dari mahasiswa departemen Matematika.
-- ================================================================
SELECT AVG(ipk) FROM student WHERE departement = 'Math';

-- ================================================================
-- SOAL NO 6: SUM
-- Tampilkan total pembayaran mahasiswa dari departemen Fisika
-- (Catatan: Tidak ada kolom pembayaran dalam tabel, menggunakan SUM IPK sebagai alternatif)
-- ================================================================
SELECT SUM(ipk) AS total_ipk_physics FROM student WHERE departement = 'Physics';

-- ================================================================
-- SOAL NO 7: COUNT
-- Tampilkan jumlah mahasiswa dari departemen Komputer.
-- ================================================================
SELECT COUNT(*) AS jumlah_mahasiswa_computer FROM student WHERE departement = 'Computer';

-- ================================================================
-- SOAL NO 8: GROUP BY
-- Tampilkan jumlah mahasiswa dari setiap departemen.
-- ================================================================
SELECT departement, COUNT(*) AS jumlah_mahasiswa 
FROM student 
GROUP BY departement;

-- ================================================================
-- SOAL NO 9: GROUP BY dengan kondisi
-- Tampilkan jumlah mahasiswa yang dikelompokkan berdasarkan city address
-- dengan usia dibawah 20 tahun.
-- ================================================================
SELECT city_address, COUNT(*) AS jumlah_mahasiswa_under20 
FROM student 
WHERE age < 20 
GROUP BY city_address;