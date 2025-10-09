-- Active: 1758272946900@@127.0.0.1@3307@hospitalDB
CREATE DATABASE IF NOT EXISTS hospitalDB;
USE hospitalDB;

-- ==========================
-- Tabel Spesialisasi Dokter
-- ==========================
CREATE TABLE Specialty (
  SpecialtyNumber INT PRIMARY KEY AUTO_INCREMENT,
  SpecialtyName   VARCHAR(100) NOT NULL
);

-- ==========================
-- Tabel Dokter
-- ==========================
CREATE TABLE Doctor (
  DoctorID        INT PRIMARY KEY AUTO_INCREMENT,
  Name            VARCHAR(100) NOT NULL,
  Phone           VARCHAR(20),
  SpecialtyNumber INT,
  Supervisor      VARCHAR(100),
  FOREIGN KEY (SpecialtyNumber) REFERENCES Specialty(SpecialtyNumber)
);

-- ==========================
-- Tabel Pasien
-- ==========================
CREATE TABLE Patient (
  PatientID   INT PRIMARY KEY AUTO_INCREMENT,
  Name        VARCHAR(100) NOT NULL,
  Phone       VARCHAR(20),
  Email       VARCHAR(100),
  Address     VARCHAR(255),
  AddedDate   DATE,
  DoctorID    INT,
  FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID)
);

-- ==========================
-- Tabel Janji Temu (Appointment)
-- ==========================
CREATE TABLE Appointment (
  AppointmentID   INT PRIMARY KEY AUTO_INCREMENT,
  DoctorID        INT,
  PatientID       INT,
  AppointmentDate DATE,
  BloodPressure   VARCHAR(20),
  Weight          DECIMAL(5,2),
  TreatmentNotes  TEXT,
  FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID),
  FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
);

-- ==========================
-- Tabel Obat (Medicine)
-- ==========================
CREATE TABLE Medicine (
  MedicineID   INT PRIMARY KEY AUTO_INCREMENT,
  MedicineName VARCHAR(100) NOT NULL
);

-- ==========================
-- Relasi Pasien & Obat
-- ==========================
CREATE TABLE PatientMedicine (
  AppointmentID INT,
  MedicineID    INT,
  PRIMARY KEY (AppointmentID, MedicineID),
  FOREIGN KEY (AppointmentID) REFERENCES Appointment(AppointmentID),
  FOREIGN KEY (MedicineID)    REFERENCES Medicine(MedicineID)
);

-- ==========================
-- Tabel Alergi
-- ==========================
CREATE TABLE Allergy (
  AllergyID   INT PRIMARY KEY AUTO_INCREMENT,
  AllergyName VARCHAR(100) NOT NULL
);

-- ==========================
-- Relasi Pasien & Alergi
-- ==========================
CREATE TABLE PatientAllergy (
  AllergyID INT,
  PatientID INT,
  PRIMARY KEY (AllergyID, PatientID),
  FOREIGN KEY (AllergyID) REFERENCES Allergy(AllergyID),
  FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
);


-- Spesialisasi
INSERT INTO Specialty (SpecialtyName) VALUES
('Penyakit Dalam'),
('Paru'),
('Anak'),
('Bedah Umum');

-- Dokter
INSERT INTO Doctor (Name, Phone, SpecialtyNumber, Supervisor) VALUES
('Dr. Kevin', '087761790968', 1, 'Dr. Antonio'),
('Dr. Watson',  '0812-222-222', 2, 'Dr. Holmes'),
('Dr. Clara',   '0813-333-333', 3, 'Dr. John'),
('Dr. Kent',    '0814-444-444', 4, 'Dr. Wayne');

-- Pasien
INSERT INTO Patient (Name, Phone, Email, Address, AddedDate, DoctorID) VALUES
('Tony Stark',   '0821-111-111', 'tony@avenger.com', 'Jl. Mawar No.1', '2024-10-01', 1),
('Peter Parker', '0822-222-222', 'peter@avenger.com','Jl. Melati No.3','2024-10-02', 1),
('Bruce Wayne',  '0823-333-333', 'bruce@wayne.com',  'Jl. Anggrek 9',  '2024-09-25', 2),
('Diana Prince', '0824-444-444', 'diana@amazon.com', 'Jl. Sakura 7',   '2024-10-05', 3),
('Clark Kent',   '0825-555-555', 'clark@daily.com',  'Jl. Flamboyan 5','2024-10-07', 4);

-- Alergi
INSERT INTO Allergy (AllergyName) VALUES
('Debu'),
('Serbuk Bunga'),
('Obat Antibiotik');

-- Relasi Pasien-Alergi
INSERT INTO PatientAllergy (AllergyID, PatientID) VALUES
(1, 2),  -- Peter Parker alergi debu
(2, 4),  -- Diana alergi serbuk bunga
(3, 1);  -- Tony alergi antibiotik

-- Obat
INSERT INTO Medicine (MedicineName) VALUES
('Paracetamol'),
('Amoxicillin'),
('Ventolin'),
('Vitamin C');

-- Appointment
INSERT INTO Appointment (DoctorID, PatientID, AppointmentDate, BloodPressure, Weight, TreatmentNotes) VALUES
(1, 1, '2024-10-10', '120/80', 75, 'Check up rutin'),
(1, 2, '2024-10-11', '115/70', 68, 'Flu ringan'),
(2, 3, '2024-10-12', '130/90', 102, 'Batuk kronis'),
(3, 4, '2024-10-13', '110/70', 58, 'Demam'),
(4, 5, '2024-10-14', '125/80', 100, 'Kontrol pasca operasi');

-- Relasi Pasien-Obat
INSERT INTO PatientMedicine (AppointmentID, MedicineID) VALUES
(1, 4),  -- Tony diberi Vitamin C
(2, 1),  -- Peter diberi Paracetamol
(3, 3),  -- Bruce diberi Ventolin
(4, 1),  -- Diana diberi Paracetamol
(5, 2);  -- Clark diberi Amoxicillin

-- dokter yang belum pernah menangani pasien
SELECT
    d.Name
FROM
    Doctor d
LEFT JOIN Patient p ON p.DoctorID = d.DoctorID
WHERE p.DoctorID IS NULL
GROUP BY d.Name;

-- nama pasien dari dr. Strange
SELECT
    p.Name
FROM
    Patient p
INNER JOIN Doctor d ON d.DoctorID = p.DoctorID
WHERE d.Name LIKE '%Strange%';

-- nama dari pasien dr.Strange yang pernah diberi obat "Paracetamol"
SELECT
    p.Name
FROM
    Patient p
INNER JOIN Doctor d ON d.DoctorID = p.DoctorID
INNER JOIN Appointment a ON a.PatientID = p.PatientID
INNER JOIN PatientMedicine pm ON pm.AppointmentID = a.AppointmentID
INNER JOIN Medicine m ON m.MedicineID = pm.MedicineID
WHERE d.Name LIKE '%Strange%' 
    AND m.MedicineName = 'Paracetamol';

-- pasien dr spesialis paru yg memiliki alergi debu
SELECT
    p.Name
FROM
    Patient p
INNER JOIN Doctor d ON d.DoctorID = p.DoctorID 
INNER JOIN PatientAllergy pa ON pa.PatientID = p.PatientID
INNER JOIN Specialty sp ON sp.SpecialtyNumber = d.SpecialtyNumber
INNER JOIN Allergy a ON a.AllergyID = pa.AllergyID
WHERE a.AllergyName = 'Debu' 
    AND sp.SpecialtyName = 'Paru';

-- dokter spesialis penyakit dalam yg pny pasien dengan berat badan min 100kg
SELECT
    DISTINCT(d.Name)
FROM
    `Doctor` d
INNER JOIN `Appointment` a ON a.`DoctorID` = d.`DoctorID`
INNER JOIN `Specialty` s ON s.`SpecialtyNumber` = d.`SpecialtyNumber`
WHERE a.`Weight` > 99 AND s.`SpecialtyName` = 'Penyakit Dalam';

-- semua nama dokter, spesialisnya, nama pasien yg ditangani
SELECT
    d.Name,
    s.SpecialtyName,
    p.Name
FROM
    `Doctor` d
INNER JOIN `Specialty` s ON s.`SpecialtyNumber` = d.`SpecialtyNumber`
INNER JOIN `Patient` p ON p.`DoctorID` = d.`DoctorID`;

-- nama pasien dr Strange yang pernah diterapi dengan obat paracetamol
SELECT
    p.Name
FROM
    `Patient` p
INNER JOIN `Doctor` d ON d.`DoctorID` = p.`DoctorID`
INNER JOIN `Appointment` a ON p.`PatientID` = a.`PatientID`
INNER JOIN `PatientMedicine` pm ON a.`AppointmentID` = pm.`AppointmentID`
INNER JOIN `Medicine` m ON m.`MedicineID` = pm.`MedicineID`
WHERE m.`MedicineName` = 'Paracetamol' AND d.`Name` LIKE '%Strange%';