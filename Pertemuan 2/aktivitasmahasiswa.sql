CREATE DATABASE IF NOT EXISTS akademik;

USE akademik;

CREATE TABLE IF NOT EXISTS dosen(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    NIP VARCHAR(20) NOT NULL UNIQUE,
    Nama VARCHAR(100) NOT NULL,
    Jenis_Kelamin ENUM('L', 'P') NOT NULL,
    Jabatan VARCHAR(100) NOT NULL,
    Minat VARCHAR(100) NOT NULL,
    Telepon VARCHAR(15) NOT NULL
);

CREATE TABLE IF NOT EXISTS mahasiswa (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    NIM VARCHAR(20) NOT NULL UNIQUE,
    Nama VARCHAR(100) NOT NULL,
    Jenis_Kelamin ENUM('L', 'P') NOT NULL,
    Tempat_Lahir VARCHAR(100) NOT NULL,
    Tanggal_Lahir DATE NOT NULL,
    Telepon VARCHAR(15) NOT NULL,
    Pembimbing_Akademik INT NOT NULL,

    FOREIGN KEY (Pembimbing_Akademik) REFERENCES dosen(id)
);

CREATE TABLE IF NOT EXISTS mata_kuliah(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Kode_MK VARCHAR(20) NOT NULL UNIQUE,
    Nama_MK VARCHAR(100) NOT NULL,
    SKS INT NOT NULL,
    Dosen_Pengampu INT NOT NULL,
    Hari VARCHAR(20) NOT NULL,
    Waktu TIME NOT NULL,
    Ruang_Kelas VARCHAR(20) NOT NULL,

    FOREIGN KEY (Dosen_Pengampu) REFERENCES dosen(id)
);

CREATE TABLE IF NOT EXISTS KRS(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Mahasiswa_ID INT NOT NULL,
    Mata_Kuliah_ID INT NOT NULL,
    Semester INT NOT NULL,
    Tahun_Akademik VARCHAR(20) NOT NULL,
    Nilai CHAR(3),

    FOREIGN KEY (Mahasiswa_ID) REFERENCES mahasiswa(id),
    FOREIGN KEY (Mata_Kuliah_ID) REFERENCES mata_kuliah(id)
);

use akademik;

-- 1. Hapus (drop) primary key pada "NIP"
ALTER TABLE dosen DROP INDEX NIP;

-- 2. Tambahkan kembali primary key pada "NIP"
ALTER TABLE dosen ADD PRIMARY KEY (NIP);

-- 3. Lihat kolom tabel "dosen"
DESCRIBE dosen;
-- atau
SHOW COLUMNS FROM dosen;

-- 4. Ubah nama tabel "dosen" menjadi "profesor"
RENAME TABLE dosen TO profesor;

-- 5. Ubah nama atribut "nama" dengan "nama_dosen"
ALTER TABLE profesor CHANGE nama nama_dosen VARCHAR(100) NOT NULL;

-- 6. Ubah tipe data "jenis_kelamin" menjadi enum {'laki-laki', 'perempuan'}
ALTER TABLE profesor MODIFY Jenis_Kelamin ENUM('laki-laki', 'perempuan') NOT NULL;

-- 7. Ubah tipe data "telepon" menjadi int
ALTER TABLE profesor MODIFY Telepon INT NOT NULL;