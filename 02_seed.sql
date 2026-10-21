INSERT INTO dokter (nama_dokter, spesialis, no_hp) VALUES
('Dr. Andi Putra', 'Umum', '081234567801'),
('Dr. Bunga Sari', 'Penyakit Dalam', '081234567802');

INSERT INTO pasien (nama_pasien, tanggal_lahir, alamat, no_hp) VALUES
('Nadia Putri', '2002-04-12', 'Bandung', '081234567811'),
('Raka Pratama', '1998-09-23', 'Cimahi', '081234567812'),
('Dina Lestari', '2001-01-05', 'Sumedang', '081234567813');

INSERT INTO obat (nama_obat, jenis_obat, harga, stok) VALUES
('Paracetamol', 'Tablet', 5000.00, 100),
('Vitamin C', 'Tablet', 8000.00, 80),
('Antasida', 'Tablet', 6000.00, 60);

INSERT INTO supplier (id_obat, nama_supplier, alamat, no_hp) VALUES
(1, 'PT Sehat Sentosa', 'Bandung', '02270000001'),
(2, 'CV Medika Jaya', 'Cimahi', '02270000002'),
(3, 'PT Farma Utama', 'Bandung', '02270000003');

INSERT INTO transaksi (id_pasien, id_obat, tanggal, jenis_transaksi, jumlah, total_harga) VALUES
(1, 1, CURRENT_DATE, 'penjualan', 2, 10000.00),
(2, 2, CURRENT_DATE, 'penjualan', 1, 8000.00),
(3, 3, CURRENT_DATE, 'penjualan', 3, 18000.00);

INSERT INTO konsultasi (id_dokter, id_pasien, catatan) VALUES
(1, 1, 'Konsultasi umum'),
(1, 2, 'Pemeriksaan awal'),
(2, 1, 'Konsultasi lanjutan'),
(2, 3, 'Pemeriksaan rutin');
