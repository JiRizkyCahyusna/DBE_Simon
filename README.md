# DBE_Simon

# 🎓 Sistem Kehadiran Mahasiswa - Database SQL

Repositori ini berisi kumpulan query SQL untuk membangun sistem database kehadiran mahasiswa menggunakan MySQL. Sistem ini mencakup tabel pengguna (`user`), dosen, mahasiswa, kelas, mata kuliah, serta pencatatan kehadiran mahasiswa. Termasuk juga query JOIN dan VIEW untuk mempermudah pengambilan data.

---
#
## 🧱 Struktur Tabel dan Relasi
🆕 Tabel dan Query CREATE
👤 Tabel user
Menyimpan data pengguna sistem.
--sql
CREATE TABLE user (
  id_user INT(10) AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(30) NOT NULL,
  password VARCHAR(30) NOT NULL,
  level VARCHAR(30) NOT NULL
);

👨‍🏫 Tabel dosen
Menyimpan data dosen, terhubung dengan user.

sql
Salin
Edit
CREATE TABLE dosen (
  nidn INT(10) PRIMARY KEY,
  nama_dosen VARCHAR(30) NOT NULL,
  id_user INT(10) NOT NULL,
  FOREIGN KEY (id_user) REFERENCES user(id_user) ON DELETE CASCADE ON UPDATE CASCADE
);
🏫 Tabel kelas
Menyimpan kode dan nama kelas.

sql
Salin
Edit
CREATE TABLE kelas (
  kode_kelas VARCHAR(5) PRIMARY KEY,
  nama_kelas VARCHAR(30) NOT NULL
);
🎓 Tabel mahasiswa
Data mahasiswa dengan relasi ke user dan kelas.

sql
Salin
Edit
CREATE TABLE mahasiswa (
  npm INT(10) PRIMARY KEY,
  nama_mahasiswa VARCHAR(30) NOT NULL,
  email VARCHAR(40) NOT NULL,
  id_user INT(10) NOT NULL,
  kode_kelas VARCHAR(5) NOT NULL,
  FOREIGN KEY (id_user) REFERENCES user(id_user) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (kode_kelas) REFERENCES kelas(kode_kelas) ON DELETE CASCADE ON UPDATE CASCADE
);
📚 Tabel matkul
Data mata kuliah dengan SKS.

sql
Salin
Edit
CREATE TABLE matkul (
  kode_matkul VARCHAR(5) PRIMARY KEY,
  nama_matkul VARCHAR(30) NOT NULL,
  sks INT(4) NOT NULL
);
🗓️ Tabel kehadiran
Mencatat kehadiran mahasiswa per pertemuan.

sql
Salin
Edit
CREATE TABLE kehadiran (
  id_kehadiran INT(5) AUTO_INCREMENT PRIMARY KEY,
  tanggal DATE NOT NULL,
  pertemuan INT(5) NOT NULL,
  status ENUM('Hadir', 'Alpha', 'Izin', 'Sakit') NOT NULL,
  npm INT(10) NOT NULL,
  nidn INT(10) NOT NULL,
  kode_matkul VARCHAR(5) NOT NULL,
  kode_kelas VARCHAR(5) NOT NULL,
  FOREIGN KEY (npm) REFERENCES mahasiswa(npm) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (nidn) REFERENCES dosen(nidn) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (kode_matkul) REFERENCES matkul(kode_matkul) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (kode_kelas) REFERENCES kelas(kode_kelas) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT unique_kehadiran UNIQUE (npm, tanggal, pertemuan)
);
