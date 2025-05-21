CREATE TABLE kehadiran (
id_kehadiran INT(5) AUTO_INCREMENT PRIMARY KEY,
tanggal DATE NOT NULL,
pertemuan INT(5) NOT NULL,
status ENUM('Hadir', 'Alpha', 'Izin', 'Sakit') NOT NULL,
npm INT(10) NOT NULL,
nidn int(10) NOT NULL,
kode_matkul VARCHAR(5) NOT NULL,
kode_kelas VARCHAR(5) NOT NULL,
FOREIGN KEY (npm) REFERENCES mahasiswa(npm) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (nidn) REFERENCES dosen(nidn) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (kode_matkul) REFERENCES matkul(kode_matkul) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (kode_kelas) REFERENCES kelas(kode_kelas) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT unique_kehadiran UNIQUE (npm, tanggal, pertemuan) );