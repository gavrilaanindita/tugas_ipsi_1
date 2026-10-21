-- HANYA untuk database latihan apotek_tugas3.
-- Perintah ini menghapus seluruh tabel latihan.
BEGIN;
DROP TABLE IF EXISTS konsultasi;
DROP TABLE IF EXISTS transaksi;
DROP TABLE IF EXISTS supplier;
DROP TABLE IF EXISTS obat;
DROP TABLE IF EXISTS pasien;
DROP TABLE IF EXISTS dokter;
COMMIT;
