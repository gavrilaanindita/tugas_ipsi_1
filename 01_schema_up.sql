BEGIN;

CREATE TABLE dokter (
    id_dokter INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nama_dokter VARCHAR(100) NOT NULL CHECK (length(trim(nama_dokter)) > 0),
    spesialis VARCHAR(80) NOT NULL,
    no_hp VARCHAR(20)
);

CREATE TABLE pasien (
    id_pasien INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nama_pasien VARCHAR(100) NOT NULL CHECK (length(trim(nama_pasien)) > 0),
    tanggal_lahir DATE CHECK (tanggal_lahir IS NULL OR tanggal_lahir <= CURRENT_DATE),
    alamat VARCHAR(200),
    no_hp VARCHAR(20)
);

CREATE TABLE obat (
    id_obat INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nama_obat VARCHAR(100) NOT NULL CHECK (length(trim(nama_obat)) > 0),
    jenis_obat VARCHAR(60) NOT NULL,
    harga NUMERIC(12,2) NOT NULL CHECK (harga >= 0),
    stok INTEGER NOT NULL DEFAULT 0 CHECK (stok >= 0),
    CONSTRAINT uq_obat_nama_jenis UNIQUE (nama_obat, jenis_obat)
);

CREATE TABLE supplier (
    id_supplier INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_obat INTEGER NOT NULL,
    nama_supplier VARCHAR(100) NOT NULL CHECK (length(trim(nama_supplier)) > 0),
    alamat VARCHAR(200),
    no_hp VARCHAR(20) NOT NULL CHECK (length(trim(no_hp)) >= 8),
    CONSTRAINT fk_supplier_obat FOREIGN KEY (id_obat)
        REFERENCES obat(id_obat) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE transaksi (
    id_transaksi INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_pasien INTEGER NOT NULL,
    id_obat INTEGER NOT NULL,
    tanggal DATE NOT NULL DEFAULT CURRENT_DATE,
    jenis_transaksi VARCHAR(20) NOT NULL DEFAULT 'penjualan'
        CHECK (jenis_transaksi IN ('penjualan','pembelian')),
    jumlah INTEGER NOT NULL CHECK (jumlah > 0),
    total_harga NUMERIC(12,2) NOT NULL CHECK (total_harga >= 0),
    CONSTRAINT fk_transaksi_pasien FOREIGN KEY (id_pasien)
        REFERENCES pasien(id_pasien) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_transaksi_obat FOREIGN KEY (id_obat)
        REFERENCES obat(id_obat) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE konsultasi (
    id_dokter INTEGER NOT NULL,
    id_pasien INTEGER NOT NULL,
    tanggal_konsultasi TIMESTAMPTZ NOT NULL DEFAULT now(),
    catatan VARCHAR(300),
    CONSTRAINT konsultasi_pkey PRIMARY KEY (id_dokter, id_pasien, tanggal_konsultasi),
    CONSTRAINT fk_konsultasi_dokter FOREIGN KEY (id_dokter)
        REFERENCES dokter(id_dokter) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_konsultasi_pasien FOREIGN KEY (id_pasien)
        REFERENCES pasien(id_pasien) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE INDEX idx_transaksi_pasien ON transaksi(id_pasien);
CREATE INDEX idx_transaksi_obat ON transaksi(id_obat);
CREATE INDEX idx_transaksi_tanggal ON transaksi(tanggal);
CREATE INDEX idx_supplier_obat ON supplier(id_obat);
CREATE INDEX idx_konsultasi_pasien ON konsultasi(id_pasien);

COMMIT;
