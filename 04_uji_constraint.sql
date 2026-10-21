DO $$
DECLARE
  v_id_dokter INT;
BEGIN
  -- UJI 1: Primary key duplikat
  SELECT id_dokter INTO v_id_dokter
  FROM dokter LIMIT 1;

  BEGIN
    INSERT INTO dokter (id_dokter, nama_dokter, spesialis)
    OVERRIDING SYSTEM VALUE
    VALUES (v_id_dokter, 'Duplikat', 'Umum');

    RAISE EXCEPTION 'GAGAL UJI 1: primary key duplikat diterima';
  EXCEPTION WHEN unique_violation THEN
    RAISE NOTICE 'LULUS UJI 1: primary key duplikat ditolak';
  END;

  -- UJI 2: Kolom wajib tidak boleh NULL
  BEGIN
    INSERT INTO pasien (nama_pasien) VALUES (NULL);
    RAISE EXCEPTION 'GAGAL UJI 2: nama NULL diterima';
  EXCEPTION WHEN not_null_violation THEN
    RAISE NOTICE 'LULUS UJI 2: nama NULL ditolak';
  END;

  -- UJI 3: Foreign key pasien tidak valid
  BEGIN
    INSERT INTO transaksi (id_pasien, id_obat, jumlah, total_harga)
    VALUES (999999, 1, 1, 1000);
    RAISE EXCEPTION 'GAGAL UJI 3: FK pasien tidak valid diterima';
  EXCEPTION WHEN foreign_key_violation THEN
    RAISE NOTICE 'LULUS UJI 3: FK pasien tidak valid ditolak';
  END;

  -- UJI 4: Foreign key obat tidak valid
  BEGIN
    INSERT INTO transaksi (id_pasien, id_obat, jumlah, total_harga)
    VALUES (1, 999999, 1, 1000);
    RAISE EXCEPTION 'GAGAL UJI 4: FK obat tidak valid diterima';
  EXCEPTION WHEN foreign_key_violation THEN
    RAISE NOTICE 'LULUS UJI 4: FK obat tidak valid ditolak';
  END;

  -- UJI 5: Harga negatif
  BEGIN
    INSERT INTO obat (nama_obat, jenis_obat, harga, stok)
    VALUES ('Obat Harga Negatif', 'Tablet', -1, 1);
    RAISE EXCEPTION 'GAGAL UJI 5: harga negatif diterima';
  EXCEPTION WHEN check_violation THEN
    RAISE NOTICE 'LULUS UJI 5: harga negatif ditolak';
  END;

  -- UJI 6: Stok negatif
  BEGIN
    INSERT INTO obat (nama_obat, jenis_obat, harga, stok)
    VALUES ('Obat Stok Negatif', 'Tablet', 1000, -1);
    RAISE EXCEPTION 'GAGAL UJI 6: stok negatif diterima';
  EXCEPTION WHEN check_violation THEN
    RAISE NOTICE 'LULUS UJI 6: stok negatif ditolak';
  END;

  -- UJI 7: Jenis transaksi tidak valid
  BEGIN
    INSERT INTO transaksi (id_pasien, id_obat, jumlah, total_harga, jenis_transaksi)
    VALUES (1, 1, 1, 1000, 'jenis-salah');
    RAISE EXCEPTION 'GAGAL UJI 7: jenis transaksi salah diterima';
  EXCEPTION WHEN check_violation THEN
    RAISE NOTICE 'LULUS UJI 7: jenis transaksi salah ditolak';
  END;

  -- UJI 8: Jumlah transaksi nol
  BEGIN
    INSERT INTO transaksi (id_pasien, id_obat, jumlah, total_harga)
    VALUES (1, 1, 0, 0);
    RAISE EXCEPTION 'GAGAL UJI 8: jumlah nol diterima';
  EXCEPTION WHEN check_violation THEN
    RAISE NOTICE 'LULUS UJI 8: jumlah nol ditolak';
  END;

  -- UJI 9: Nomor HP supplier terlalu pendek
  BEGIN
    INSERT INTO supplier (id_obat, nama_supplier, alamat, no_hp)
    VALUES (1, 'Supplier Demo', 'Bandung', '123');
    RAISE EXCEPTION 'GAGAL UJI 9: nomor HP pendek diterima';
  EXCEPTION WHEN check_violation THEN
    RAISE NOTICE 'LULUS UJI 9: nomor HP pendek ditolak';
  END;

  -- UJI 10: Obat yang direferensikan tidak dapat dihapus
  BEGIN
    DELETE FROM obat WHERE id_obat = 1;
    RAISE EXCEPTION 'GAGAL UJI 10: obat direferensikan berhasil dihapus';
  EXCEPTION WHEN foreign_key_violation THEN
    RAISE NOTICE 'LULUS UJI 10: obat yang direferensikan tidak dapat dihapus';
  END;
END $$;
