import 'package:equatable/equatable.dart';

class PenempatanSister extends Equatable {
  PenempatanSister({
    required this.penempatan,
    required this.jabFung,
    required this.inpassing,
    required this.kepangkatan,
    required this.message,
  });
  late final List<Penempatan> penempatan;
  late final List<JabFung> jabFung;
  late final List<Kepangkatan> kepangkatan;
  late final List<Inpassing> inpassing;
  late final String message;

  PenempatanSister.fromJson(Map<String, dynamic> json) {
    penempatan = List.from(json['data']['penempatan'])
        .map((e) => Penempatan.fromJson(e))
        .toList();
    jabFung = List.from(json['data']['jabatan_fungsional'])
        .map((e) => JabFung.fromJson(e))
        .toList();
    kepangkatan = List.from(json['data']['kepangkatan'])
        .map((e) => Kepangkatan.fromJson(e))
        .toList();
    inpassing = List.from(json['data']['inpassing'])
        .map((e) => Inpassing.fromJson(e))
        .toList();
    message = json['message'];
    print("==========INI DATA PENEMPATAN===========");
    print(penempatan);
  }

  @override
  List<Object?> get props => [
        penempatan,
        jabFung,
        inpassing,
        kepangkatan,
        message,
      ];
}

class Penempatan extends Equatable {
  Penempatan({
    required this.nidn,
    required this.statusKepegawaian,
    required this.ikatanKerja,
    required this.jenjangDidik,
    required this.unitProdi,
    required this.perguruanTinggi,
    required this.tmtSkPenugasan,
    required this.tanggalKeluar,
    required this.jenisKeluar,
    // required this.penyelanggara,
    // required this.apakah_homebase,
  });
  late final String nidn;
  late final String statusKepegawaian;
  late final String ikatanKerja;
  late final String jenjangDidik;
  // late final String penyelanggara;
  late final String unitProdi;
  late final String perguruanTinggi;
  late final String tmtSkPenugasan;
  late final String tanggalKeluar;
  late final String jenisKeluar;
  // late final bool apakah_homebase;

  Penempatan.fromJson(Map<String, dynamic> json) {
    nidn = json["nidn"] != null ? json['nidn'] : '-';
    statusKepegawaian =
        json["status_kepegawaian"] != null ? json['status_kepegawaian'] : '-';
    ikatanKerja = json["ikatan_kerja"] != null ? json['ikatan_kerja'] : '-';
    jenjangDidik = json["jenjang_didik"] != null ? json['jenjang_didik'] : '-';
    // penyelanggara = json["penyelanggara"];
    unitProdi = json["nm_prodi"] != null ? json['nm_prodi'] : '-';
    perguruanTinggi = json["nm_pt"] != null ? json['nm_pt'] : '-';
    tmtSkPenugasan =
        json["tmt_sk_penugasan"] != null ? json['tmt_sk_penugasan'] : '-';
    tanggalKeluar = json["tgl_keluar"] != null ? json['tgl_keluar'] : '-';
    jenisKeluar = json["jenis_keluar"] != null ? json['jenis_keluar'] : '-';
    // apakah_homebase = json["apakah_homebase"];
  }

  @override
  List<Object?> get props => [
        nidn,
        statusKepegawaian,
        ikatanKerja,
        jenjangDidik,
        unitProdi,
        perguruanTinggi,
        tmtSkPenugasan,
        tanggalKeluar,
        jenisKeluar,
      ];
}

class JabFung extends Equatable {
  late final String jabfung;
  late final String skJabfung;
  late final String tanggalMulai;

  JabFung(
      {required this.jabfung,
      required this.skJabfung,
      required this.tanggalMulai});

  JabFung.fromJson(Map<String, dynamic> json) {
    jabfung = json['jabfung'] != null ? json['jabfung'] : '-';
    skJabfung = json['sk_jabfung'] != null ? json['sk_jabfung'] : '-';
    tanggalMulai =
        json['tmt_sk_jabfung'] != null ? json['tmt_sk_jabfung'] : '-';
  }
  @override
  List<Object?> get props => [jabfung, skJabfung, tanggalMulai];
}

class Kepangkatan extends Equatable {
  late final String golongan;
  late final String pangkat;
  late final String nomorSK;
  late final String tglMulai;

  Kepangkatan(
      {required this.golongan,
      required this.nomorSK,
      required this.pangkat,
      required this.tglMulai});

  Kepangkatan.fromJson(Map<String, dynamic> json) {
    golongan = json['pangkat_gol']['golongan'] != null
        ? json['pangkat_gol']['golongan']
        : '-';
    pangkat = json['pangkat_gol']['pangkat'] != null
        ? json['pangkat_gol']['pangkat']
        : '-';
    nomorSK = json['sk_pangkat'] != null ? json['sk_pangkat'] : '-';
    tglMulai = json['tmt_sk_pangkat'] != null ? json['tmt_sk_pangkat'] : '-';
  }
  @override
  List<Object?> get props => [golongan, nomorSK, pangkat, tglMulai];
}

class Inpassing extends Equatable {
  late final String golongan;
  late final String pangkat;
  late final String nomorInpassing;
  late final String tglSkInpassing;
  late final String tglMulaiInpassing;

  Inpassing({
    required this.golongan,
    required this.pangkat,
    required this.nomorInpassing,
    required this.tglSkInpassing,
    required this.tglMulaiInpassing,
  });

  Inpassing.fromJson(Map<String, dynamic> json) {
    golongan = json['pangkat_gol']['golongan'] != null
        ? json['pangkat_gol']['golongan']
        : '-';
    pangkat = json['pangkat_gol']['pangkat'] != null
        ? json['pangkat_gol']['pangkat']
        : '-';
    nomorInpassing = json['sk_inpassing'] != null ? json['sk_inpassing'] : '-';
    tglSkInpassing =
        json['tgl_sk_inpassing'] != null ? json['tgl_sk_inpassing'] : '-';
    tglMulaiInpassing =
        json['tmt_sk_inpassing'] != null ? json['tmt_sk_inpassing'] : '-';
  }

  @override
  List<Object?> get props => [
        golongan,
        pangkat,
        nomorInpassing,
        tglSkInpassing,
        tglMulaiInpassing,
      ];
}
