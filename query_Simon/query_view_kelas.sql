CREATE VIEW v_kelas AS
SELECT 
    ROW_NUMBER() OVER (ORDER BY kode_kelas) AS No,
    kelas.* 
FROM Kelas;