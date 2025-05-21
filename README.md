# DBE_Simon

# 🎓 Sistem Kehadiran Mahasiswa - Database SQL

Repositori ini berisi kumpulan query SQL untuk membangun sistem database kehadiran mahasiswa menggunakan MySQL. Sistem ini mencakup tabel pengguna (`user`), dosen, mahasiswa, kelas, mata kuliah, serta pencatatan kehadiran mahasiswa. Termasuk juga query JOIN dan VIEW untuk mempermudah pengambilan data.

---
#
## Gambar ERD

![SIMON ERD](https://github.com/user-attachments/assets/39f821d1-541d-4021-a5e5-353e6b190b50)

**🔁 Relasi Kardinalitas Antar Tabel**
1. User → Dosen (1 : 1) :
Setiap user hanya dapat mewakili satu dosen, dan seorang dosen hanya memiliki satu akun user. Hubungan ini menunjukkan relasi satu-satu.

2. User → Mahasiswa (1 : 1) :
Seorang user hanya dapat terhubung dengan satu mahasiswa, dan setiap mahasiswa memiliki satu akun user. Ini adalah relasi satu-satu juga.

3. Kelas → Mahasiswa (1 : N) :
Satu kelas bisa berisi banyak mahasiswa, tetapi setiap mahasiswa hanya dapat berada dalam satu kelas. Ini merupakan relasi satu ke banyak.

4. Dosen → Kehadiran (1 : N) :
Seorang dosen bisa memiliki banyak data kehadiran karena mengajar lebih dari satu kelas atau mata kuliah. Artinya, satu dosen terhubung ke banyak catatan kehadiran.

5. Mahasiswa → Kehadiran (1 : N) :
Seorang mahasiswa bisa memiliki banyak data kehadiran karena mengikuti berbagai mata kuliah. Ini juga merupakan relasi satu ke banyak.

6. Mata Kuliah → Kehadiran (1 : N) :
Setiap mata kuliah bisa memiliki banyak data kehadiran karena diikuti oleh banyak mahasiswa. Relasi ini juga satu ke banyak.

7. Kelas → Kehadiran (1 : N) :
Satu kelas dapat muncul dalam banyak data kehadiran karena mencakup kehadiran mahasiswa di berbagai pertemuan. Ini juga relasi satu ke banyak.




## 🧱 Struktur Tabel dan Relasi
## 1. 🆕 Tabel dan Query CREATE
- 👤 **Tabel user**  

  Menyimpan data pengguna sistem.

```sql
CREATE TABLE user (
  id_user INT(10) AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(30) NOT NULL,
  password VARCHAR(30) NOT NULL,
  level VARCHAR(30) NOT NULL
);
```

- 👨‍🏫 **Tabel dosen**

  Menyimpan data dosen, terhubung dengan user.

```sql
  CREATE TABLE dosen (
  nidn INT(10) PRIMARY KEY,
  nama_dosen VARCHAR(30) NOT NULL,
  id_user INT(10) NOT NULL,
  FOREIGN KEY (id_user) REFERENCES user(id_user) ON DELETE CASCADE ON UPDATE CASCADE
);
```

- 🏫 **Tabel kelas**

Menyimpan kode dan nama kelas.

```sql
CREATE TABLE kelas (
  kode_kelas VARCHAR(5) PRIMARY KEY,
  nama_kelas VARCHAR(30) NOT NULL
);
```

- **🎓 Tabel mahasiswa**

Data mahasiswa dengan relasi ke user dan kelas.

```sql
CREATE TABLE mahasiswa (
  npm INT(10) PRIMARY KEY,
  nama_mahasiswa VARCHAR(30) NOT NULL,
  email VARCHAR(40) NOT NULL,
  id_user INT(10) NOT NULL,
  kode_kelas VARCHAR(5) NOT NULL,
  FOREIGN KEY (id_user) REFERENCES user(id_user) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (kode_kelas) REFERENCES kelas(kode_kelas) ON DELETE CASCADE ON UPDATE CASCADE
);
```

- **📚 Tabel matkul**

Data mata kuliah dengan SKS.

```sql
CREATE TABLE matkul (
  kode_matkul VARCHAR(5) PRIMARY KEY,
  nama_matkul VARCHAR(30) NOT NULL,
  sks INT(4) NOT NULL
);
```


- **🗓️ Tabel kehadiran**

Mencatat kehadiran mahasiswa per pertemuan.

```sql
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
```
## 2. 📥 Data Insertion (INSERT)

Bagian ini berisi query untuk menambahkan data ke dalam tabel-tabel pada database.

- **👤 Tabel user**

Menambahkan data user dengan atribut username, password, dan level.

```sql
INSERT INTO user (username, password, level) VALUES
('Andin Ardelina', 'andin03', 'dosen'),
('Ji Rizky Cahyusna', 'nana12', 'mahasiswa'),
('Hana Kurnia', 'hana14', 'admin'),
('Windy Anggita', 'windy23', 'dosen'),
('Ibnu Zaki', 'ibnu22', 'mahasiswa'),
('Putri Aulia', 'putri29', 'dosen'),
('Surya Wijaya', 'surya30', 'dosen'),
('Amelia Zahra', 'amel91', 'mahasiswa'),
('Santosa Setiya', 'santosa76', 'mahasiswa'),
('Dedi Prasetyo', 'dedi56', 'dosen'),
('Sarah Amaleya', 'sarah40', 'mahasiswa');
```

- **👨‍🏫 Tabel dosen**
  
Memasukkan data dosen beserta nidn, nama, dan referensi id_user.

```sql
INSERT INTO dosen VALUES
(2206231, 'Andin Ardelina', 1),
(2206232, 'Windy Anggita', 4),
(2206233, 'Putri Aulia', 6),
(2206234, 'Surya Wijaya', 7),
(2206235, 'Dedi Prasetyo', 10);
```

- **🏫 Tabel kelas**
  
Menambah data kelas dengan kode dan nama kelas.

```sql
INSERT INTO kelas VALUES 
('KLS01', 'A'),
('KLS02', 'B'),
('KLS03', 'C'),
('KLS04', 'D'),
('KLS05', 'E');
```

- **🎓 Tabel mahasiswa**
  
Menambahkan data mahasiswa lengkap dengan NPM, nama, email, id_user, dan kelas.

```sql
INSERT INTO mahasiswa VALUES
(330102065, 'Ji Rizky Cahyusna', 'jicantik12@gmail.com', 2, 'KLS03'),
(330102066, 'Ibnu Zaki', 'ibnuzaki@gmail.com', 5, 'KLS05'),
(330102067, 'Amelia Zahra', 'amelia@gmail.com', 8, 'KLS04'),
(330102068, 'Santosa Setiya', 'santosa@gmail.com', 9, 'KLS01'),
(330102069, 'Sarah Amaleya', 'sarah@gmail.com', 11, 'KLS02');
```

- **📚 Tabel matkul**
  
Memasukkan data mata kuliah dengan kode, nama, dan jumlah SKS.

```sql
INSERT INTO matkul VALUES
('MTK01', 'Matematika Dasar', 3),
('FIS02', 'Fisika', 2),
('PGR03', 'Pemrograman Web', 4),
('SBD04', 'Sistem Basis Data', 3),
('JRM05', 'Jaringan Komputer', 3);
```

- **📝 Tabel kehadiran**
  
Menambahkan data kehadiran mahasiswa untuk mata kuliah tertentu, tanggal, pertemuan, dan status.

```sql
INSERT INTO kehadiran (tanggal, pertemuan, status, npm, nidn, kode_matkul, kode_kelas) VALUES
('2025-02-11', 1, 'Hadir', 330102065, 2206232, 'SBD04', 'KLS03'),
('2025-02-12', 1, 'Izin', 330102066, 2206235, 'FIS02', 'KLS05'),
('2025-02-13', 2, 'Sakit', 330102067, 2206231, 'JRM05', 'KLS04'),
('2025-02-14', 2, 'Alpha', 330102068, 2206234, 'MTK01', 'KLS01'),
('2025-02-15', 3, 'Hadir', 330102069, 2206233, 'PGR03', 'KLS02');
```

## 3. 🔍 Query SELECT

Query SELECT digunakan untuk mengambil data dari tabel dalam database dengan tampilan yang rapi dan terurut.

- **📚 Query untuk mengambil data dari tabel kelas**

Menampilkan daftar kelas lengkap dengan nomor urut.

```sql
SELECT 
    ROW_NUMBER() OVER (ORDER BY kode_kelas) AS No,
    kelas.* 
FROM Kelas;
```
- **👨‍🏫 Query untuk mengambil data dari tabel dosen**

Menampilkan daftar dosen dengan nomor urut berdasarkan NIDN.

```sql
SELECT 
  ROW_NUMBER() OVER (ORDER BY d.nidn) AS No,
  d.nidn, d.nama_dosen 
FROM Dosen d;
```

- **📖 Query untuk mengambil data dari tabel matkul**

Menampilkan daftar mata kuliah lengkap dengan nomor urut.

```sql
SELECT 
    ROW_NUMBER() OVER (ORDER BY kode_matkul) AS No,
    matkul.* 
FROM Matkul;
```

## 4. 🔗 JOIN QUERY
- **🎓 Mahasiswa dan Kelas**

```sql
SELECT 
  ROW_NUMBER() OVER (ORDER BY m.npm) AS No,
  m.npm, m.nama_mahasiswa, m.email, k.nama_kelas
FROM Mahasiswa m
JOIN Kelas k ON m.kode_kelas = k.kode_kelas;
```
- 📝 Penjelasan:
Query ini digunakan untuk menampilkan data mahasiswa beserta nama kelasnya. Tabel mahasiswa di-JOIN dengan tabel kelas berdasarkan kolom kode_kelas yang menjadi relasi antara keduanya.

- **📝 Kehadiran Lengkap**
```sql
SELECT 
  m.npm, m.nama_mahasiswa, kh.tanggal, kh.pertemuan, kh.status,
  mk.nama_matkul, d.nama_dosen
FROM Kehadiran kh
JOIN Mahasiswa m ON kh.npm = m.npm
JOIN Matkul mk ON kh.kode_matkul = mk.kode_matkul
JOIN Dosen d ON kh.nidn = d.nidn;
```
- 📝 Penjelasan:
  
Query ini menampilkan data kehadiran lengkap, termasuk informasi mahasiswa, dosen, dan mata kuliah. Query ini melakukan beberapa JOIN sekaligus:
- JOIN Mahasiswa: Menghubungkan kehadiran dengan data mahasiswa melalui npm
- JOIN Matkul: Menghubungkan kehadiran dengan mata kuliah melalui kode_matkul
- JOIN Dosen: Menghubungkan kehadiran dengan dosen melalui nidn


## 5. 👁️ VIEW Query

VIEW adalah tabel virtual yang dibuat berdasarkan hasil dari query SELECT. VIEW tidak menyimpan data secara fisik di database, melainkan menampilkan data secara dinamis dari satu atau lebih tabel.
- **👁️ View Kelas**

Menampilkan daftar semua kelas.
```sql
CREATE VIEW v_kelas AS
SELECT ROW_NUMBER() OVER (ORDER BY kode_kelas) AS No, kelas.* FROM Kelas;
```
- **👁️ View Dosen**

Menampilkan data dosen dengan NIDN dan nama.
```sql
CREATE VIEW v_dosen AS
SELECT ROW_NUMBER() OVER (ORDER BY d.nidn) AS No, d.nidn, d.nama_dosen FROM Dosen d;
```
- **👁️ View Matkul**

Menampilkan semua mata kuliah lengkap dengan SKS.
```sql
CREATE VIEW v_matkul AS
SELECT ROW_NUMBER() OVER (ORDER BY kode_matkul) AS No, matkul.* FROM Matkul;
```
- **👁️ View Mahasiswa + Kelas**

Menampilkan data mahasiswa lengkap dengan nama kelasnya.
```sql
CREATE VIEW v_mahasiswa_kelas AS
SELECT ROW_NUMBER() OVER (ORDER BY m.npm) AS No,  
    m.npm, m.nama_mahasiswa, m.email, k.nama_kelas
FROM Mahasiswa m 
JOIN Kelas k ON m.kode_kelas = k.kode_kelas;
```
- **👁️ View Kehadiran Mahasiswa Lengkap**
  
	Menampilkan data kehadiran mahasiswa lengkap dengan nama dosen & matkul.
```sql
CREATE VIEW v_kehadiran_mahasiswa AS
SELECT kh.id_kehadiran, m.npm, m.nama_mahasiswa, kh.tanggal, kh.pertemuan, kh.status, 
  mk.nama_matkul, d.nama_dosen
FROM Kehadiran kh
JOIN Mahasiswa m ON kh.npm = m.npm
JOIN Matkul mk ON kh.kode_matkul = mk.kode_matkul
JOIN Dosen d ON kh.nidn = d.nidn;
```









