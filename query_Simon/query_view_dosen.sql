CREATE VIEW v_dosen AS
SELECT 
    ROW_NUMBER() OVER (ORDER BY d.nidn) AS No,
    d.nidn, d.nama_dosen 
FROM Dosen d;