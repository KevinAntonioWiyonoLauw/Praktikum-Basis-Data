-- Active: 1757838666175@@localhost@3307@week7
-- Active: 1757838666175@@localhost@3307@week6
CREATE DATABASE IF NOT EXISTS week7;

USE week7;

CREATE TABLE IF NOT EXISTS User(
    userID INT AUTO_INCREMENT PRIMARY KEY,
    userName VARCHAR(255) NOT NULL,
    numberOfBorrowing INT DEFAULT 0,
    numberOfReturning INT DEFAULT 0
);

CREATE TABLE IF NOT EXISTS Books(
    bookID INT AUTO_INCREMENT PRIMARY KEY,
    bookTitle VARCHAR(255) NOT NULL,
    authorName VARCHAR(255) NOT NULL,
    borrowedStatus BOOLEAN DEFAULT FALSE
);

CREATE TABLE IF NOT EXISTS Flow(
    flowID INT AUTO_INCREMENT PRIMARY KEY,
    userIDBorrowing INT NOT NULL,
    bookIDBorrowed INT NOT NULL,
    borrowDate DATE NOT NULL,
    returnDate DATE NULL,

    FOREIGN KEY (userIDBorrowing) REFERENCES User(userID),
    FOREIGN KEY (bookIDBorrowed) REFERENCES Books(bookID)
);

INSERT INTO User (userName, numberOfBorrowing, numberOfReturning) VALUES
('Ahmad Rizki', 5, 3),
('Sari Dewi', 2, 2),
('Budi Santoso', 8, 6),
('Maya Indira', 1, 0),
('Doni Pratama', 3, 1),
('Rina Kartika', 4, 4),
('Fajar Nugroho', 0, 0),
('Lisa Permata', 6, 5),
('Andi Wijaya', 2, 1),
('Nita Salsabila', 7, 6);

INSERT INTO Books (bookTitle, authorName, borrowedStatus) VALUES
('Laskar Pelangi', 'Andrea Hirata', TRUE),
('Bumi Manusia', 'Pramoedya Ananta Toer', FALSE),
('Ayat-Ayat Cinta', 'Habiburrahman El Shirazy', TRUE),
('Negeri 5 Menara', 'Ahmad Fuadi', FALSE),
('Perahu Kertas', 'Dee Lestari', TRUE),
('Sang Pemimpi', 'Andrea Hirata', FALSE),

('Clean Code', 'Robert C. Martin', TRUE),
('Design Patterns', 'Gang of Four', FALSE),
('Database System Concepts', 'Silberschatz', TRUE),
('Introduction to Algorithms', 'Cormen', FALSE),

('Rich Dad Poor Dad', 'Robert Kiyosaki', FALSE),
('The 7 Habits', 'Stephen Covey', TRUE),
('Think and Grow Rich', 'Napoleon Hill', FALSE),
('Atomic Habits', 'James Clear', TRUE),

('A Brief History of Time', 'Stephen Hawking', FALSE),
('Cosmos', 'Carl Sagan', TRUE),
('The Art of Problem Solving', 'Richard Rusczyk', FALSE),
('Calculus', 'James Stewart', FALSE);

INSERT INTO Flow (userIDBorrowing, bookIDBorrowed, borrowDate, returnDate) VALUES
(1, 2, '2024-08-01', '2024-08-15'),
(2, 4, '2024-08-05', '2024-08-20'),
(3, 6, '2024-08-10', '2024-08-25'),
(6, 8, '2024-08-12', '2024-08-27'),
(8, 11, '2024-08-15', '2024-08-30'),

(3, 10, '2024-09-01', '2024-09-16'),
(5, 13, '2024-09-03', '2024-09-18'),
(8, 15, '2024-09-05', '2024-09-20'),
(9, 17, '2024-09-08', '2024-09-23'),
(10, 18, '2024-09-10', '2024-09-25'),


(1, 1, '2024-09-25', NULL),     
(1, 3, '2024-09-28', NULL),     
(4, 5, '2024-09-29', NULL),     
(5, 7, '2024-09-30', NULL),     
(8, 9, '2024-09-30', NULL),     
(9, 12, '2024-10-01', NULL),    
(10, 14, '2024-10-01', NULL),   
(3, 16, '2024-10-01', NULL),

(2, 2, CURDATE() - INTERVAL 1 DAY, NULL),     
(6, 4, CURDATE() - INTERVAL 1 DAY, NULL),    
(7, 6, CURDATE() - INTERVAL 1 DAY, NULL),
(2, 8, CURDATE() - INTERVAL 1 DAY, NULL),
(5, 4, CURDATE() - INTERVAL 1 DAY, NULL);

-- 2a) Semua judul buku status dipinjam dan tanggal peminjaman = kemarin
SELECT b.bookTitle
FROM Books b
WHERE b.borrowedStatus = TRUE
  AND EXISTS (
    SELECT *
    FROM Flow f
    WHERE f.bookIDBorrowed = b.bookID
      AND f.borrowDate = CURDATE() - INTERVAL 1 DAY
      AND f.returnDate IS NULL
  );

-- 2b) Semua judul buku; untuk yang sedang dipinjam tampilkan userID peminjam, selain itu NULL
SELECT
  b.bookTitle,
  (
    SELECT f.userIDBorrowing
    FROM Flow f
    WHERE f.bookIDBorrowed = b.bookID
      AND f.returnDate IS NULL
    ORDER BY f.borrowDate DESC
    LIMIT 1
  ) AS userIDBorrowing
FROM Books b;

-- 2c) Semua buku yang sedang dipinjam dan semua userID (baik ia sedang meminjam atau tidak)
(
  SELECT
    b.bookTitle AS bookTitle,
    NULL        AS userID
  FROM Books b
  WHERE EXISTS (
    SELECT 1
    FROM Flow f
    WHERE f.bookIDBorrowed = b.bookID
      AND f.returnDate IS NULL
  )
)
UNION ALL
(
  SELECT
    NULL       AS bookTitle,
    u.userID   AS userID
  FROM `User` u
);

-- 2d) Satu query: daftar semua judul buku dan userName yang sedang meminjam buku dan user tsb pernah meminjam > 3 buku
SELECT
  b.bookTitle,
  u.userName
FROM Books b
JOIN Flow f
  ON f.bookIDBorrowed = b.bookID
  AND f.returnDate IS NULL               
JOIN `User` u
  ON u.userID = f.userIDBorrowing
WHERE u.userID IN (
  SELECT f2.userIDBorrowing
  FROM Flow f2
  GROUP BY f2.userIDBorrowing
  HAVING COUNT(*) > 3
);
