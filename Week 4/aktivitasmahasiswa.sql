-- Active: 1754133432363@@localhost@3307@aktivitasmahasiswa43
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

INSERT INTO student (nim, name, city_address, age, IPK, departement) VALUES
('12345', 'Adi', 'Jakarta', 17, 2.5, 'Math'),
('12346', 'Ani', 'Yogyakarta', 20, 2.1, 'Math'),
('12347', 'Ari', 'Surabaya', 18, 2.5, 'Computer'),
('12348', 'Ali', 'Banjarmasin', 20, 3.5, 'Computer'),
('12349', 'Abi', 'Medan', 19, 3.7, 'Computer'),
('12350', 'Budi', 'Jakarta', 19, 2.8, 'Computer'),
('12351', 'Boni', 'Yogyakarta', 20, 3.2, 'Computer'),
('12352', 'Bobi', 'Surabaya', 18, 2.7, 'Computer'),
('12353', 'Beni', 'Banjarmasin', 18, 2.2, 'Computer'),
('12354', 'Cepi', 'Jakarta', 20, 2.2, NULL),
('12355', 'Coni', 'Yogyakarta', 19, 2.8, NULL),
('12356', 'Ceki', 'Surabaya', 20, 3.1, NULL),
('12357', 'Dodi', 'Jakarta', 19, 3.3, 'Math'),
('12358', 'Didi', 'Yogyakarta', 20, 3.5, 'Physics'),
('12359', 'Deri', 'Surabaya', 19, 3.3, 'Physics'),
('12360', 'Eli', 'Jakarta', 20, 2.9, 'Physics'),
('12361', 'Endah', 'Yogyakarta', 18, 2.8, NULL),
('12362', 'Feni', 'Jakarta', 17, 2.7, NULL),
('12363', 'Farah', 'Yogyakarta', 18, 3.4, NULL),
('12364', 'Fandi', 'Surabaya', 19, 3.4, NULL);

-- 2. Tampilkan kolom city address tanpa ada duplikat. 
SELECT DISTINCT city_address FROM student;

-- 3. Tampilkan data nama mahasiswa dari departemen komputer.
SELECT name FROM student WHERE departement = 'Computer';

-- 4. Tampilkan data NIM, nama, usia, dan city address yang diurutkan dari mahasiswa tertua.
SELECT nim, name, age, city_address FROM student ORDER BY age DESC;

-- 5. Tampilkan nama dan usia 3 mahasiswa termuda dari Jakarta.
SELECT name, age FROM student WHERE city_address = 'Jakarta' ORDER BY age ASC LIMIT 3;

-- 6. Tampilkan nama dan IPK mahasiswa asal Jakarta dengan IPK dibawah 2,5.
SELECT name, ipk FROM student WHERE city_address = 'Jakarta' AND ipk < 2.5;

-- 7. Tampilkan setiap nama mahasiswa dari Yogyakarta atau memiliki usia lebih tua dari 20.
SELECT name FROM student WHERE city_address = 'Yogyakarta' OR age > 20;

-- 8. Tampilkan nama dan alamat mahasiswa yang bukan dari Jakarta dan Surabaya.
SELECT name, city_address FROM student WHERE city_address NOT LIKE 'Jakarta' AND city_address NOT LIKE 'Surabaya';

-- 9. Tampilkan nama, umur dan IPK mahasiswa dengan IPK dari 2,5 hingga 3,5.
SELECT name, age, ipk FROM student WHERE ipk BETWEEN 2.5 and 3.5;

-- 10.Tampilkan nama mahasiswa yang memiliki huruf n pada namanya.
SELECT name FROM student WHERE name LIKE '%n%';

-- 11.Tampilkan NIM mahasiswa dengan data Null.
SELECT nim FROM student WHERE departement IS NULL;