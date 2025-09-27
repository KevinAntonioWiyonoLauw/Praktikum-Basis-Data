/*
Kasus: Sistem Hotel
1. Buat database Hotel.
2. Definisikan tabel Kamar, Tamu, Reservasi dengan primary key dan foreign key.
3. Tambahkan kolom no_hp pada tabel Tamu.
4. Hapus tabel Reservasi kemudian buat ulang dengan struktur yang berbeda
*/

CREATE DATABASE IF NOT EXISTS Hotel;

USE Hotel;

CREATE TABLE IF NOT EXISTS Kamar (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nomor_kamar VARCHAR(10) NOT NULL UNIQUE,
    tipe_kamar ENUM('Single', 'Double', 'Suite') NOT NULL,
    harga DECIMAL(10, 2) NOT NULL,
    status ENUM('Tersedia', 'Terisi') NOT NULL DEFAULT 'Tersedia'
);

CREATE TABLE IF NOT EXISTS Tamu (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    alamat VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS Reservasi (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_tamu INT NOT NULL,
    id_kamar INT NOT NULL,
    tanggal_check_in DATE NOT NULL,
    tanggal_check_out DATE NOT NULL,
    status ENUM('Dipesan', 'Selesai', 'Dibatalkan') NOT NULL DEFAULT 'Dipesan',

    FOREIGN KEY (id_tamu) REFERENCES Tamu(id),
    FOREIGN KEY (id_kamar) REFERENCES Kamar(id)
);

-- 3. Tambahkan kolom no_hp pada tabel Tamu
ALTER TABLE Tamu ADD COLUMN no_hp VARCHAR(15) NOT NULL;

-- 4. Hapus tabel Reservasi kemudian buat ulang dengan struktur yang berbeda
DROP TABLE IF EXISTS Reservasi;
CREATE TABLE IF NOT EXISTS Reservasi (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_tamu INT NOT NULL,
    id_kamar INT NOT NULL,
    tanggal_check_in DATETIME NOT NULL,
    tanggal_check_out DATETIME NOT NULL,
    status ENUM('Dipesan', 'Selesai', 'Dibatalkan') NOT NULL DEFAULT 'Dipesan',
    metode_pembayaran ENUM('Kartu Kredit', 'Debit', 'Tunai') NOT NULL,

    FOREIGN KEY (id_tamu) REFERENCES Tamu(id),
    FOREIGN KEY (id_kamar) REFERENCES Kamar(id)
);