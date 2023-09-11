import 'package:equatable/equatable.dart';

class BiodataSister extends Equatable {
  late final String message;
  late final int status;
  late final Data data;

  BiodataSister(
      {required this.message, required this.status, required this.data});

  BiodataSister.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = Data.fromJson(json['data']);
  }
  @override
  List<Object?> get props => [message, status, data];
}

class Data extends Equatable {
  late final Profile profile;
  late final AlamatKontak alamatKontak;
  late final Kualifikasi kualifikasi;
  late final Kependudukan kependudukan;
  late final Keluarga keluarga;
  late final Kepegawaian kepegawaian;
  late final LainLain lainLain;

  Data(
      {required this.profile,
      required this.alamatKontak,
      required this.kualifikasi,
      required this.kependudukan,
      required this.keluarga,
      required this.kepegawaian,
      required this.lainLain});

  Data.fromJson(Map<String, dynamic> json) {
    profile = Profile.fromJson(json['profile']);
    alamatKontak = AlamatKontak.fromJson(json['alamat_kontak']);
    kualifikasi = Kualifikasi.fromJson(json['kualifikasi']);
    kependudukan = Kependudukan.fromJson(json['kependudukan']);
    keluarga = Keluarga.fromJson(json['keluarga']);
    kepegawaian = Kepegawaian.fromJson(json['kepegawaian']);
    lainLain = LainLain.fromJson(json['lain_lain']);
  }

  @override
  List<Object?> get props => [
        profile,
        alamatKontak,
        kualifikasi,
        kependudukan,
        keluarga,
        kepegawaian,
        lainLain
      ];
}

class Profile extends Equatable {
  late final String nama;
  late final String nidn;
  late final String jenisKelamin;
  late final String tempatLahir;
  late final String tglLahir;
  late final int usia;

  Profile(
      {required this.nama,
      required this.nidn,
      required this.jenisKelamin,
      required this.tempatLahir,
      required this.tglLahir,
      required this.usia});

  Profile.fromJson(Map<String, dynamic> json) {
    nama = json['nama'] ?? '-';
    nidn = json['nidn'] ?? '-';
    jenisKelamin = json['jenis_kelamin'] ?? '-';
    tempatLahir = json['tempat_lahir'] ?? '-';
    tglLahir = json['tgl_lahir'] ?? '-';
    usia = json['usia'];
  }
  @override
  List<Object?> get props => [
        nama,
        nidn,
        jenisKelamin,
        tempatLahir,
        tglLahir,
        usia,
      ];
}

class AlamatKontak extends Equatable {
  late final String email;
  late final String jalan;
  late final String rt;
  late final String rw;
  late final String desaKelurahan;
  late final String kotaKabupaten;
  late final String kodePos;
  late final String noTelp;
  late final String noHp;
  late final String dusun;
  late final String provinsi;

  AlamatKontak(
      {required this.email,
      required this.jalan,
      required this.dusun,
      required this.provinsi,
      required this.rt,
      required this.rw,
      required this.desaKelurahan,
      required this.kotaKabupaten,
      required this.kodePos,
      required this.noTelp,
      required this.noHp});

  AlamatKontak.fromJson(Map<String, dynamic> json) {
    email = json['email'] ?? '-';
    jalan = json['jalan'] ?? '-';
    dusun = json['dusun'] ?? '-';
    provinsi = json['provinsi'] ?? '-';
    rt = json['rt'] ?? '-';
    rw = json['rw'] ?? '-';
    desaKelurahan = json['desa_kelurahan'] ?? '-';
    kotaKabupaten = json['kota_kabupaten'] ?? '-';
    kodePos = json['kode_pos'] ?? '-';
    noTelp = json['no_telp'] ?? '-';
    noHp = json['no_hp'] ?? '-';
  }

  @override
  List<Object?> get props => [
        email,
        jalan,
        rt,
        rw,
        desaKelurahan,
        kotaKabupaten,
        kodePos,
        noTelp,
        noHp,
        dusun,
        provinsi
      ];
}

class Kualifikasi extends Equatable {
  late final Jabfung jabfung;
  late final String pendidikanTerakhir;
  late final Kepangkatan kepangkatan;
  late final String sertifikasiDosen;

  Kualifikasi(
      {required this.jabfung,
      required this.pendidikanTerakhir,
      required this.kepangkatan,
      required this.sertifikasiDosen});

  Kualifikasi.fromJson(Map<String, dynamic> json) {
    jabfung = Jabfung.fromJson(json['jabfung']);
    pendidikanTerakhir = json['pendidikan_terakhir'] ?? "-";
    kepangkatan = Kepangkatan.fromJson(json['kepangkatan']);
    sertifikasiDosen = json['sertifikasi_dosen'] ?? null;
  }

  @override
  List<Object?> get props =>
      [jabfung, pendidikanTerakhir, kepangkatan, sertifikasiDosen];
}

class Jabfung extends Equatable {
  late final String nama;
  late final int angkaKredit;

  Jabfung({required this.nama, required this.angkaKredit});

  Jabfung.fromJson(Map<String, dynamic> json) {
    nama = json['nama'] ?? '-';
    angkaKredit = json['angka_kredit'];
  }
  @override
  List<Object?> get props => [
        nama,
        angkaKredit,
      ];
}

class Kepangkatan extends Equatable {
  late final String golongan;
  late final String pangkat;

  Kepangkatan({required this.golongan, required this.pangkat});

  Kepangkatan.fromJson(Map<String, dynamic> json) {
    golongan = json['golongan'] ?? '-';
    pangkat = json['pangkat'] ?? '-';
  }

  @override
  List<Object?> get props => [golongan, pangkat];
}

class Kependudukan extends Equatable {
  late final String nik;
  late final String agama;
  late final String kewarganegaraan;
  Kependudukan(
      {required this.nik, required this.agama, required this.kewarganegaraan});

  Kependudukan.fromJson(Map<String, dynamic> json) {
    nik = json['nik'] ?? '-';
    agama = json['agama'] ?? '-';
    kewarganegaraan = json['kewarganegaraan'] ?? '-';
  }

  @override
  List<Object?> get props => [nik, agama, kewarganegaraan];
}

class Keluarga extends Equatable {
  late final String statusPerkawinan;
  late final String namaSuamiIstri;
  late final String nipSuamiIstri;

  Keluarga({
    required this.statusPerkawinan,
    required this.namaSuamiIstri,
    required this.nipSuamiIstri,
  });

  Keluarga.fromJson(Map<String, dynamic> json) {
    statusPerkawinan = json['status_perkawinan'] ?? '-';
    namaSuamiIstri = json['nama_suami_istri'] ?? '-';
    nipSuamiIstri = json['nip_suami_istri'] ?? '-';
  }
  @override
  List<Object?> get props => [
        statusPerkawinan,
        namaSuamiIstri,
        nipSuamiIstri,
      ];
}

class Kepegawaian extends Equatable {
  late final String pembina;
  late final String nmPt;
  late final String nmProdi;
  late final String nip;
  late final String statusKepegawaian;
  late final String statusKeaktifan;
  late final String skCpns;
  late final String tglSkCpns;
  late final String nomorSkTmmd;
  late final String tglSkTmmd;
  late final String masaKerja;
  late final String ikatanKerja;
  late final String lembagaAngkat;
  late final String sumberGaji;

  Kepegawaian(
      {required this.pembina,
      required this.nmPt,
      required this.nmProdi,
      required this.nip,
      required this.statusKepegawaian,
      required this.statusKeaktifan,
      required this.skCpns,
      required this.tglSkCpns,
      required this.nomorSkTmmd,
      required this.tglSkTmmd,
      required this.masaKerja,
      required this.ikatanKerja,
      required this.lembagaAngkat,
      required this.sumberGaji});

  Kepegawaian.fromJson(Map<String, dynamic> json) {
    pembina = json['pembina'] ?? '-';
    nmPt = json['nm_pt'] ?? '-';
    nmProdi = json['nm_prodi'] ?? '-';
    nip = json['nip'] ?? '-';
    statusKepegawaian = json['status_kepegawaian'] ?? '-';
    statusKeaktifan = json['status_keaktifan'] ?? '-';
    skCpns = json['sk_cpns'] ?? '-';
    tglSkCpns = json['tgl_sk_cpns'] ?? '-';
    nomorSkTmmd = json['nomor_sk_tmmd'] ?? '-';
    tglSkTmmd = json['tgl_sk_tmmd'] ?? '-';
    masaKerja = json['masa_kerja'] ?? '-';
    ikatanKerja = json['ikatan_kerja'] ?? '-';
    lembagaAngkat = json['lembaga_Angkat'] ?? '-';
    sumberGaji = json['sumber_gaji'] ?? '-';
  }

  @override
  List<Object?> get props => [
        pembina,
        nmPt,
        nmProdi,
        nip,
        statusKepegawaian,
        statusKeaktifan,
        skCpns,
        tglSkCpns,
        nomorSkTmmd,
        tglSkTmmd,
        masaKerja,
        ikatanKerja,
        lembagaAngkat,
        sumberGaji
      ];
}

class LainLain extends Equatable {
  late final String npwp;
  late final String namaWajibPajak;
  late final String idSinta;

  LainLain(
      {required this.npwp,
      required this.namaWajibPajak,
      required this.idSinta});

  LainLain.fromJson(Map<String, dynamic> json) {
    npwp = json['npwp'] ?? '-';
    namaWajibPajak = json['nama_wajib_pajak'] ?? '-';
    idSinta = json['id_sinta'] ?? '-';
  }

  @override
  List<Object?> get props => [npwp, namaWajibPajak, idSinta];
}
