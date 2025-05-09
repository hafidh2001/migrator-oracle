--------------------------------------------------------
--  DDL for Table ASSETACCOUNTS
--------------------------------------------------------

  CREATE TABLE "ASSETACCOUNTS" 
   (	"COA" VARCHAR2(4 BYTE), 
	"PENENTUAN_TINDAKAN" VARCHAR2(8 BYTE), 
	"DAERAH_PENYUSUTAN" NUMBER(2,0), 
	"AKUSISI_BIAYA_PRODUKSI" VARCHAR2(10 BYTE), 
	"KLIRING_PENG_PENJ_ASET" VARCHAR2(10 BYTE), 
	"KEUNTUNGAN_DARI_PENJ_AS" VARCHAR2(10 BYTE), 
	"PENDAPATAN_APC" VARCHAR2(10 BYTE), 
	"KERUGIAN_PENJUALAN_ASET" VARCHAR2(10 BYTE), 
	"KERUGIAN_PENSIUN_ASET" VARCHAR2(10 BYTE), 
	"CRAETED_DATE" DATE, 
	"UPDATE_DATE" DATE
   );
--------------------------------------------------------
--  DDL for Table ASSETCLASSES
--------------------------------------------------------

  CREATE TABLE "ASSETCLASSES" 
   (	"ASET_KELAS" VARCHAR2(8 BYTE), 
	"DIBUAT_OLEH" VARCHAR2(12 BYTE), 
	"DIBUAT_TANGGAL" DATE, 
	"DIEDIT_OLEH" VARCHAR2(12 BYTE), 
	"DIEDIT_TGL" DATE, 
	"DESKRIPSI" VARCHAR2(50 BYTE), 
	"KET" VARCHAR2(50 BYTE), 
	"CRAETED_DATE" DATE, 
	"UPDATE_DATE" DATE, 
	"GROUPASSET_ID" VARCHAR2(6 BYTE), 
	"GROUPCLASSES_ID" VARCHAR2(12 BYTE), 
	"FLAG" CHAR(1 BYTE)
   );
--------------------------------------------------------
--  DDL for Table ASSETS
--------------------------------------------------------

  CREATE TABLE "ASSETS" 
   (	"NO_ASET" VARCHAR2(16 BYTE), 
	"SUB_ASET" VARCHAR2(4 BYTE), 
	"NAMA_ASET" VARCHAR2(100 BYTE), 
	"KELAS_ASET" VARCHAR2(8 BYTE), 
	"KODE_CABANG" VARCHAR2(5 BYTE), 
	"PUSAT_BIAYA" VARCHAR2(10 BYTE), 
	"TGL_KAPITALISASI" DATE, 
	"TGL_MULAI_PENYUSUTAN" DATE, 
	"DIMENSI_NILAI" NUMBER(11,0), 
	"DIMENSI_SATUAN" CHAR(15 BYTE), 
	"CREATED_BY" VARCHAR2(20 BYTE), 
	"CREATED_ON" TIMESTAMP (6), 
	"MODIFIED_BY" VARCHAR2(20 BYTE), 
	"MODIFIED_ON" TIMESTAMP (6), 
	"STATUS" VARCHAR2(1 BYTE), 
	"PERIODE" NUMBER(2,0), 
	"TAHUN" NUMBER(4,0), 
	"GROUPCLASSES_ID" NUMBER, 
	"GROUPASSET_ID" VARCHAR2(12 BYTE), 
	"SISA_MANFAAT" NUMBER, 
	"PROFIT_CENTER" VARCHAR2(5 BYTE)
   );
--------------------------------------------------------
--  DDL for Table ASSET_SAP_FAILED
--------------------------------------------------------

  CREATE TABLE "ASSET_SAP_FAILED" 
   (	"ID" NUMBER, 
	"NO_ASET" VARCHAR2(16 BYTE), 
	"PERIODE" NUMBER, 
	"TAHUN" NUMBER, 
	"EXCEPTION" CLOB, 
	"REQUEST" CLOB, 
	"CREATED_AT" TIMESTAMP (6), 
	"CREATED_BY" VARCHAR2(100 BYTE), 
	"NAMA_ASET" VARCHAR2(100 BYTE), 
	"KODE_PLANT" VARCHAR2(7 BYTE)
   );
--------------------------------------------------------
--  DDL for Table BRANCHES
--------------------------------------------------------

  CREATE TABLE "BRANCHES" 
   (	"ID_CABANG" VARCHAR2(4 BYTE), 
	"NAMA_CABANG" VARCHAR2(50 BYTE), 
	"CRAETED_DATE" DATE, 
	"UPDATE_DATE" DATE, 
	"KODE_REGIONAL" VARCHAR2(5 BYTE), 
	"KODE_TERMINAL" VARCHAR2(5 BYTE), 
	"KODE_SAP" VARCHAR2(5 BYTE), 
	"PROFIT_CENTER" VARCHAR2(5 BYTE), 
	"FLAG_APPROVE" NUMBER
   );
--------------------------------------------------------
--  DDL for Table COSTCENTERS
--------------------------------------------------------

  CREATE TABLE "COSTCENTERS" 
   (	"KODE_PUSAT_BIAYA" VARCHAR2(10 BYTE), 
	"NAMA_PUSAT_BIAYA" VARCHAR2(200 BYTE), 
	"FLAG" VARCHAR2(1 BYTE), 
	"CRAETED_DATE" DATE, 
	"UPDATE_DATE" DATE
   );
--------------------------------------------------------
--  DDL for Table DEPRECIATIONS
--------------------------------------------------------

  CREATE TABLE "DEPRECIATIONS" 
   (	"KODE_PENYUSUTAN" VARCHAR2(4 BYTE), 
	"NAMA_PENYUSUTAN" VARCHAR2(35 BYTE), 
	"CRAETED_DATE" DATE, 
	"UPDATE_DATE" DATE
   );
--------------------------------------------------------
--  DDL for Table DEPRECIATION_VALUES
--------------------------------------------------------

  CREATE TABLE "DEPRECIATION_VALUES" 
   (	"NO_ASET" VARCHAR2(16 BYTE), 
	"SUB_ASET" VARCHAR2(4 BYTE), 
	"NILAI_SUSUT" NUMBER(23,2) DEFAULT 0, 
	"AKUMULASI_PENYUSUTAN" NUMBER(23,2) DEFAULT 0, 
	"NILAI_PEROLEHAN" NUMBER(23,2) DEFAULT 0, 
	"NILAI_BUKU" NUMBER(23,2) DEFAULT 0, 
	"NILAI_RESIDU" NUMBER(23,2) DEFAULT 0, 
	"PERIODE" NUMBER(2,0), 
	"TAHUN" NUMBER(4,0), 
	"CREATED_BY" VARCHAR2(20 BYTE), 
	"CREATED_ON" TIMESTAMP (6), 
	"PENURUNAN_AKUMULASI_NILAI" NUMBER(23,0), 
	"PEMULIHAN_AKUMULASI_NILAI" NUMBER(23,0), 
	"AKUMULASI_PENYUSUTAN_NEW" NUMBER(23,2), 
	"PENYUSUTAN_SD_BLN_BERJALAN" NUMBER(23,2)
   );
--------------------------------------------------------
--  DDL for Table DETAILASSETS
--------------------------------------------------------

  CREATE TABLE "DETAILASSETS" 
   (	"NO_ASET" VARCHAR2(16 BYTE), 
	"DETAIL_MEREK" VARCHAR2(50 BYTE), 
	"DETAIL_NO_RANGKA" VARCHAR2(25 BYTE), 
	"DETAIL_NO_MESIN" VARCHAR2(25 BYTE), 
	"DETAIL_NO_PLAT" VARCHAR2(25 BYTE), 
	"SUB_ASET" VARCHAR2(4 BYTE), 
	"DETAIL_TIPE" VARCHAR2(25 BYTE), 
	"KETERANGAN" VARCHAR2(255 BYTE), 
	"PENURUNAN_TGL_PEMBUKUAN" DATE, 
	"PENURUNAN_LEMBAGA" VARCHAR2(50 BYTE), 
	"PENURUNAN_NOMOR" VARCHAR2(20 BYTE), 
	"PENURUNAN_TGL_LAPORAN" DATE, 
	"PEMULIHAN_TGL_PEMBUKUAN" DATE, 
	"PEMULIHAN_LEMBAGA" VARCHAR2(50 BYTE), 
	"PEMULIHAN_NOMOR" VARCHAR2(20 BYTE), 
	"PEMULIHAN_TGL_LAPORAN" DATE, 
	"NO_ITEM" NUMBER(2,0), 
	"LOKASI" VARCHAR2(100 BYTE), 
	"KORDINAT" VARCHAR2(60 BYTE), 
	"KONDISI_FISIK" VARCHAR2(4 BYTE), 
	"STATUS_PEROLEHAN" VARCHAR2(4 BYTE), 
	"BUKTI_KEPEMILIKAN" VARCHAR2(4 BYTE), 
	"BUKTI_RINCIAN" VARCHAR2(100 BYTE), 
	"BUKTI_NO" VARCHAR2(50 BYTE), 
	"BUKTI_TGL" DATE, 
	"BUKTI_KETERANGAN" VARCHAR2(200 BYTE), 
	"BUKTI_FISIK_DOKUMEN" VARCHAR2(4 BYTE), 
	"CREATED_BY" VARCHAR2(20 BYTE), 
	"CREATED_ON" TIMESTAMP (6), 
	"MODIFIED_BY" VARCHAR2(20 BYTE), 
	"MODIFIED_ON" TIMESTAMP (6), 
	"STATUS_ITEMINISASI" VARCHAR2(1 BYTE), 
	"PERIODE" NUMBER(2,0), 
	"TAHUN" NUMBER(4,0), 
	"STATUS_PENGELOLAAN" VARCHAR2(4 BYTE), 
	"HUKUM_RINCIAN" VARCHAR2(50 BYTE), 
	"HUKUM_NOMOR" VARCHAR2(20 BYTE), 
	"HUKUM_KETERANGAN" VARCHAR2(20 BYTE), 
	"ASURANSI" VARCHAR2(4 BYTE), 
	"KJPP_UMUR" VARCHAR2(20 BYTE), 
	"KJPP_NILAI" NUMBER(23,0), 
	"KJPP_PELAKSANA" VARCHAR2(20 BYTE), 
	"KJPP_NO" NUMBER(20,0), 
	"KJPP_TGL" DATE, 
	"USULAN_PENGHAPUSAN" VARCHAR2(4 BYTE), 
	"STATUS_ASURANSI" VARCHAR2(4 BYTE), 
	"TINDAK_LANJUT" VARCHAR2(200 BYTE), 
	"TINDAK_LANJUT_DD" CHAR(4 BYTE), 
	"KJPP_UMUR_ASURANSI" VARCHAR2(20 BYTE), 
	"KJPP_NILAI_ASURANSI" NUMBER, 
	"KJPP_PELAKSANA_ASURANSI" VARCHAR2(20 BYTE), 
	"KJPP_NO_ASURANSI" NUMBER, 
	"KJPP_TGL_ASURANSI" DATE
   );
--------------------------------------------------------
--  DDL for Table DIMENSI_SATUAN
--------------------------------------------------------

  CREATE TABLE "DIMENSI_SATUAN" 
   (	"NAME" VARCHAR2(20 BYTE)
   );
--------------------------------------------------------
--  DDL for Table ELIMINATION
--------------------------------------------------------

  CREATE TABLE "ELIMINATION" 
   (	"NO_ASET" VARCHAR2(16 BYTE), 
	"SUB_ASET" VARCHAR2(4 BYTE), 
	"NO_ITEM" NUMBER(2,0), 
	"PENGHAPUSAN_RINCIAN" VARCHAR2(50 BYTE), 
	"PENGHAPUSAN_NOMOR" VARCHAR2(50 BYTE), 
	"PENGHAPUSAN_KETERANGAN" VARCHAR2(50 BYTE), 
	"CREATED_BY" VARCHAR2(20 BYTE), 
	"CREATED_ON" TIMESTAMP (6), 
	"MODIFIED_BY" VARCHAR2(20 BYTE), 
	"MODIFIED_ON" TIMESTAMP (6), 
	"STATUS" VARCHAR2(1 BYTE), 
	"PERIODE" NUMBER(2,0), 
	"TAHUN" NUMBER(4,0), 
	"TANGGAL_USULAN_PENGHAPUSAN" DATE
   );
--------------------------------------------------------
--  DDL for Table FAILED_JOBS
--------------------------------------------------------

  CREATE TABLE "FAILED_JOBS" 
   (	"ID" NUMBER(19,0), 
	"CONNECTION" CLOB, 
	"QUEUE" CLOB, 
	"PAYLOAD" CLOB, 
	"EXCEPTION" CLOB, 
	"FAILED_AT" TIMESTAMP (6)
   );
--------------------------------------------------------
--  DDL for Table GROUPASSETS
--------------------------------------------------------

  CREATE TABLE "GROUPASSETS" 
   (	"ID" VARCHAR2(4 BYTE), 
	"NAMA_GROUP" VARCHAR2(255 BYTE)
   );
--------------------------------------------------------
--  DDL for Table GROUPCLASSES
--------------------------------------------------------

  CREATE TABLE "GROUPCLASSES" 
   (	"ID" NUMBER(*,0), 
	"NAMA_GROUP_KELAS" VARCHAR2(50 BYTE), 
	"KODE" NUMBER
   );
--------------------------------------------------------
--  DDL for Table INSURANCES
--------------------------------------------------------

  CREATE TABLE "INSURANCES" 
   (	"NO_ASET" VARCHAR2(16 BYTE), 
	"SUB_ASET" VARCHAR2(4 BYTE), 
	"NO_ITEM" NUMBER(2,0), 
	"RINCIAN" VARCHAR2(50 BYTE), 
	"NO_POLIS" VARCHAR2(25 BYTE), 
	"TGL_POLIS" DATE, 
	"PREMI" NUMBER(23,0), 
	"KETERANGAN_ASURANSI" VARCHAR2(50 BYTE), 
	"ALASAN_ASURANSI" VARCHAR2(50 BYTE), 
	"CREATED_BY" VARCHAR2(20 BYTE), 
	"CREATED_ON" TIMESTAMP (6), 
	"MODIFIED_BY" VARCHAR2(20 BYTE), 
	"MODIFIED_ON" TIMESTAMP (6), 
	"STATUS" VARCHAR2(1 BYTE) DEFAULT 1, 
	"PERIODE" NUMBER(2,0), 
	"TAHUN" NUMBER(4,0), 
	"NO_ASURANSI" NUMBER(2,0), 
	"SCAN" VARCHAR2(500 BYTE)
   );
--------------------------------------------------------
--  DDL for Table JOBS
--------------------------------------------------------

  CREATE TABLE "JOBS" 
   (	"ID" NUMBER(19,0), 
	"QUEUE" VARCHAR2(255 BYTE), 
	"PAYLOAD" CLOB, 
	"ATTEMPTS" NUMBER(3,0), 
	"RESERVED_AT" NUMBER(10,0), 
	"AVAILABLE_AT" NUMBER(10,0), 
	"CREATED_AT" NUMBER(10,0)
   );
--------------------------------------------------------
--  DDL for Table MASTER_ASURANSI
--------------------------------------------------------

  CREATE TABLE "MASTER_ASURANSI" 
   (	"ID" NUMBER, 
	"NO_POLIS" VARCHAR2(30 BYTE), 
	"NAMA_POLIS" VARCHAR2(80 BYTE), 
	"TGL_POLIS" DATE, 
	"PREMI" NUMBER(23,0), 
	"JANGKA_WAKTU" VARCHAR2(100 BYTE), 
	"ID_REGIONAL" NUMBER(4,0), 
	"SCAN_POLIS" VARCHAR2(100 BYTE), 
	"ACTIVE" CHAR(1 BYTE), 
	"CREATED_BY" VARCHAR2(50 BYTE), 
	"CREATED_ON" TIMESTAMP (6), 
	"UPDATED_BY" VARCHAR2(50 BYTE), 
	"UPDATED_ON" TIMESTAMP (6)
   );
--------------------------------------------------------
--  DDL for Table MIGRATIONS
--------------------------------------------------------

  CREATE TABLE "MIGRATIONS" 
   (	"ID" NUMBER(10,0), 
	"MIGRATION" VARCHAR2(255 BYTE), 
	"BATCH" NUMBER(10,0)
   );
--------------------------------------------------------
--  DDL for Table MONITORING_FAILED
--------------------------------------------------------

  CREATE TABLE "MONITORING_FAILED" 
   (	"ID" NUMBER(9,0), 
	"DESCRIPTION" VARCHAR2(50 BYTE), 
	"PERIODE" NUMBER(2,0), 
	"TAHUN" NUMBER(4,0), 
	"MODEL" VARCHAR2(6 BYTE), 
	"CREATED_AT" TIMESTAMP (6), 
	"EXCEPTION" CLOB, 
	"REQUEST" CLOB
   );
--------------------------------------------------------
--  DDL for Table MONITORING_INTEGRATOR
--------------------------------------------------------

  CREATE TABLE "MONITORING_INTEGRATOR" 
   (	"ID" NUMBER, 
	"DESCRIPTION" VARCHAR2(50 BYTE), 
	"PERIODE" NUMBER(2,0), 
	"TAHUN" NUMBER(4,0), 
	"MODEL" VARCHAR2(3 BYTE), 
	"CREATED_AT" TIMESTAMP (6)
   );
--------------------------------------------------------
--  DDL for Table NOTIFIKASI
--------------------------------------------------------

  CREATE TABLE "NOTIFIKASI" 
   (	"NO_ASET" VARCHAR2(12 BYTE), 
	"PERIODE" NUMBER(2,0), 
	"TAHUN" NUMBER(4,0), 
	"HEADER" VARCHAR2(20 BYTE), 
	"ISI_NOTIFIKASI" VARCHAR2(200 BYTE), 
	"JENIS_NOTIFIKASI" VARCHAR2(10 BYTE), 
	"STATUS" VARCHAR2(1 BYTE), 
	"CREATED_BY" VARCHAR2(20 BYTE), 
	"CREATED_ON" TIMESTAMP (6), 
	"MODIFIED_BY" VARCHAR2(10 BYTE), 
	"MODIFIED_ON" TIMESTAMP (6), 
	"ID_NOTIFIKASI" NUMBER(19,0), 
	"KODE_CABANG" VARCHAR2(8 BYTE)
   );
--------------------------------------------------------
--  DDL for Table PASSWORD_RESETS
--------------------------------------------------------

  CREATE TABLE "PASSWORD_RESETS" 
   (	"EMAIL" VARCHAR2(255 BYTE), 
	"TOKEN" VARCHAR2(255 BYTE), 
	"CREATED_AT" TIMESTAMP (6)
   );
--------------------------------------------------------
--  DDL for Table PBB
--------------------------------------------------------

  CREATE TABLE "PBB" 
   (	"NO_ASET" VARCHAR2(16 BYTE), 
	"SUB_ASET" VARCHAR2(4 BYTE), 
	"NO_ITEM" NUMBER(2,0), 
	"NJOP" NUMBER(23,2), 
	"NO_PBB" NUMBER(23,2), 
	"TGL_PBB" DATE, 
	"CREATED_BY" VARCHAR2(20 BYTE), 
	"CREATED_ON" TIMESTAMP (6), 
	"MODIFIED_BY" VARCHAR2(20 BYTE), 
	"MODIFIED_ON" TIMESTAMP (6), 
	"PERIODE" NUMBER(2,0), 
	"TAHUN" NUMBER(4,0), 
	"KETERANGAN_PBB" VARCHAR2(50 BYTE)
   );
--------------------------------------------------------
--  DDL for Table PERIOD
--------------------------------------------------------

  CREATE TABLE "PERIOD" 
   (	"ID" NUMBER(19,0), 
	"START_DATE" DATE, 
	"END_DATE" DATE, 
	"CREATED_BY" VARCHAR2(20 BYTE), 
	"CREATED_ON" TIMESTAMP (6)
   );
--------------------------------------------------------
--  DDL for Table PERIOD_REQUEST
--------------------------------------------------------

  CREATE TABLE "PERIOD_REQUEST" 
   (	"ID" NUMBER, 
	"START_DATE" DATE, 
	"END_DATE" DATE, 
	"STATUS" CHAR(1 BYTE), 
	"CREATED_BY" VARCHAR2(100 BYTE), 
	"CREATED_ON" TIMESTAMP (6), 
	"KONFIRM1_BY" VARCHAR2(100 BYTE), 
	"KONFIRM1_ON" TIMESTAMP (6), 
	"KONFIRM_BY" VARCHAR2(100 BYTE), 
	"KONFIRM_ON" TIMESTAMP (6), 
	"KODE_CABANG" VARCHAR2(10 BYTE), 
	"ID_USER" NUMBER
   );
--------------------------------------------------------
--  DDL for Table PICTUREASSETS
--------------------------------------------------------

  CREATE TABLE "PICTUREASSETS" 
   (	"SUB_ASET" NUMBER(4,0), 
	"PATH_SURAT" NVARCHAR2(500), 
	"FLAG" VARCHAR2(1 BYTE), 
	"CREATED_ON" TIMESTAMP (6), 
	"JENIS_FOTO" NUMBER(1,0), 
	"NO_ITEM" VARCHAR2(4 BYTE), 
	"NO_ASET" VARCHAR2(16 BYTE)
   );
--------------------------------------------------------
--  DDL for Table REFERENCES
--------------------------------------------------------

  CREATE TABLE "REFERENCES" 
   (	"ID" NUMBER, 
	"KATEGORI" NUMBER(2,0), 
	"ENTITY" VARCHAR2(4 BYTE), 
	"NAMA_ENTITY" VARCHAR2(100 BYTE), 
	"FLAG" VARCHAR2(1 BYTE), 
	"CREATED_BY" VARCHAR2(20 BYTE), 
	"CREATED_ON" TIMESTAMP (6), 
	"MODIFIED_BY" VARCHAR2(20 BYTE), 
	"MODIFIED_ON" TIMESTAMP (6)
   );
--------------------------------------------------------
--  DDL for Table ROLES
--------------------------------------------------------

  CREATE TABLE "ROLES" 
   (	"ID" VARCHAR2(2 BYTE), 
	"NAME" VARCHAR2(20 BYTE), 
	"ID_MENU" VARCHAR2(100 BYTE), 
	"STATUS" NUMBER(1,0), 
	"ID_INTEGRATION" NUMBER(*,0)
   );
--------------------------------------------------------
--  DDL for Table USERS
--------------------------------------------------------

  CREATE TABLE "USERS" 
   (	"ID" NUMBER(19,0), 
	"NAME" VARCHAR2(255 BYTE), 
	"EMAIL" VARCHAR2(255 BYTE), 
	"EMAIL_VERIFIED_AT" TIMESTAMP (6), 
	"PASSWORD" VARCHAR2(249 BYTE), 
	"REMEMBER_TOKEN" VARCHAR2(100 BYTE), 
	"CREATED_AT" TIMESTAMP (6), 
	"UPDATED_AT" TIMESTAMP (6), 
	"ID_CABANG" VARCHAR2(5 BYTE), 
	"ID_ROLE" VARCHAR2(20 BYTE), 
	"STATUS" VARCHAR2(1 BYTE), 
	"API_TOKEN" VARCHAR2(100 BYTE), 
	"KODE_REGIONAL" VARCHAR2(4 BYTE)
   );
--------------------------------------------------------
--  DDL for Table USES
--------------------------------------------------------

  CREATE TABLE "USES" 
   (	"NO_ASET" VARCHAR2(16 BYTE), 
	"SUB_ASET" VARCHAR2(4 BYTE), 
	"STATUS_PENGELOLAAN_RINCIAN" VARCHAR2(128 BYTE), 
	"NAMA_PENYEWA" VARCHAR2(128 BYTE), 
	"NO_KONTRAK_SEWA" VARCHAR2(32 BYTE), 
	"AWAL_PERJANJIAN" DATE, 
	"AKHIR_PERJANJIAN" DATE, 
	"CREATED_BY" VARCHAR2(20 BYTE), 
	"CREATED_ON" TIMESTAMP (6), 
	"MODIFIED_BY" VARCHAR2(20 BYTE), 
	"MODIFIED_ON" TIMESTAMP (6), 
	"PIHAK_YANG_MENEMPATI" VARCHAR2(50 BYTE), 
	"NO_ITEM" VARCHAR2(4 BYTE), 
	"TAHUN" NUMBER(4,0), 
	"PERIODE" NUMBER(4,0), 
	"USES_TYPE" CHAR(4 BYTE), 
	"NO_USES" NUMBER(*,0), 
	"SCAN" VARCHAR2(500 BYTE)
   );