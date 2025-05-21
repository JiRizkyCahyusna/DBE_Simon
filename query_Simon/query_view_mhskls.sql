CREATE VIEW v_mahasiswa_kelas AS
SELECT 
    ROW_NUMBER() OVER (ORDER BY m.npm) AS No,  
    m.npm, 
    m.nama_mahasiswa, 
    m.email, 
    k.nama_kelas 
FROM Mahasiswa m 
JOIN Kelas k ON m.kode_kelas = k.kode_kelas;