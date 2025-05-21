CREATE VIEW v_matkul AS
SELECT 
    ROW_NUMBER() OVER (ORDER BY kode_matkul) AS No,
    matkul.* 
FROM Matkul;