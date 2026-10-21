-- READ tabel
SELECT * FROM dokter ORDER BY id_dokter;
SELECT * FROM pasien ORDER BY id_pasien;
SELECT * FROM obat ORDER BY id_obat;
SELECT * FROM supplier ORDER BY id_supplier;
SELECT * FROM transaksi ORDER BY id_transaksi;
SELECT * FROM konsultasi ORDER BY tanggal_konsultasi;

-- JOIN transaksi, pasien, dan obat
SELECT t.id_transaksi, t.tanggal, t.jenis_transaksi,
       p.nama_pasien, o.nama_obat, t.jumlah, t.total_harga
FROM transaksi t
JOIN pasien p ON p.id_pasien = t.id_pasien
JOIN obat o ON o.id_obat = t.id_obat
ORDER BY t.id_transaksi;

-- Relasi many-to-many dokter dan pasien
SELECT d.nama_dokter, p.nama_pasien, k.tanggal_konsultasi, k.catatan
FROM konsultasi k
JOIN dokter d ON d.id_dokter = k.id_dokter
JOIN pasien p ON p.id_pasien = k.id_pasien
ORDER BY k.tanggal_konsultasi;

-- CREATE
INSERT INTO pasien (nama_pasien, tanggal_lahir, alamat, no_hp)
VALUES ('Pasien Demo', '2000-06-15', 'Bandung', '081234567899');

-- UPDATE
UPDATE pasien SET alamat = 'Bandung Barat'
WHERE nama_pasien = 'Pasien Demo';

-- DELETE hanya data demo
DELETE FROM pasien WHERE nama_pasien = 'Pasien Demo';

-- ROLLBACK transaksi contoh
BEGIN;
UPDATE obat SET stok = stok + 5 WHERE id_obat = 1;
SELECT id_obat, nama_obat, stok FROM obat WHERE id_obat = 1;
ROLLBACK;
SELECT id_obat, nama_obat, stok FROM obat WHERE id_obat = 1;
