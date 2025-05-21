CREATE VIEW v_kehadiran_mahasiswa AS
SELECT 
  kh.id_kehadiran, 
  m.npm, m.nama_mahasiswa, 
  kh.tanggal, kh.pertemuan, kh.status, 
  mk.nama_matkul, 
  d.nama_dosen
FROM Kehadiran kh
JOIN Mahasiswa m ON kh.npm = m.npm
JOIN Matkul mk ON kh.kode_matkul = mk.kode_matkul
JOIN Dosen d ON kh.nidn = d.nidn;