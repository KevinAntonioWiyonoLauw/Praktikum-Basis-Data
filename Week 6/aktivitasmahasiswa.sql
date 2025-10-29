-- Active: 1757838666175@@localhost@3307@week6
CREATE DATABASE IF NOT EXISTS week6;

USE week6;

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
(3, 16, '2024-10-01', NULL);    


-- Menampilkan semua judul buku dimana statusnya dipinjam (borrowed) dan tanggal peminjaman nya kemarin.
SELECT b.bookTitle, f.borrowDate
FROM Books b
JOIN Flow f ON b.bookID = f.bookIDBorrowed
WHERE b.borrowedStatus = TRUE 
  AND f.borrowDate = CURDATE() - INTERVAL 1 DAY
  AND f.returnDate IS NULL;

-- Menampilkan semua judul buku bahkan buku yang tidak dipinjam dan userID peminjamnya untuk buku yang dipinjam.
SELECT b.bookTitle, f.userIDBorrowing
FROM Books b
LEFT JOIN Flow f ON b.bookID = f.bookIDBorrowed AND f.returnDate IS NULL
ORDER BY b.bookTitle;

-- Menampilkan semua buku yang dipinjam dan semua userID apakah dia meminjam atau tidak.
SELECT 
    u.userID,
    u.userName,
    b.bookID,
    b.bookTitle,
    b.authorName,
    f.borrowDate,
    f.returnDate
FROM Flow f
RIGHT JOIN Books b ON f.bookIDBorrowed = b.bookID 
RIGHT JOIN User u ON f.userIDBorrowing = u.userID
ORDER BY u.userID, b.bookID;

-- Dengan menggunakan satu kueri, tampilkan daftar semua judul buku dan nama user yang meminjam buku tersebut dan user yang meminjam lebih dari 3 buku.
SELECT 
    b.bookTitle,
    u.userName,
    u.numberOfBorrowing AS totalPeminjaman,
    f.borrowDate,
    f.returnDate
FROM Flow f
INNER JOIN Books b ON f.bookIDBorrowed = b.bookID
INNER JOIN User u ON f.userIDBorrowing = u.userID
WHERE u.numberOfBorrowing > 3
ORDER BY u.numberOfBorrowing DESC, f.borrowDate DESC;