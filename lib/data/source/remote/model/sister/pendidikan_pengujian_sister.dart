import 'package:equatable/equatable.dart';

class PendidikanPengujianSister extends Equatable {
  late final String message;
  late final int status;
  late final List<PendidikanPengujian> pendidikanPengujian;

  PendidikanPengujianSister(
      {required this.message,
      required this.status,
      required this.pendidikanPengujian});

  PendidikanPengujianSister.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    pendidikanPengujian = List.from(json['data'])
        .map((e) => PendidikanPengujian.fromJson(e))
        .toList();
  }
  @override
  List<Object?> get props => [message, status, pendidikanPengujian];
}

class PendidikanPengujian extends Equatable {
  late final String semester;
  late final String jenisAktivitas;
  late final String judul;
  late final String nmrSk;
  late final String lokasi;
  late final String tglSk;
  late final String ketKegiatan;
  late final Prodi prodi;

  PendidikanPengujian(
      {required this.semester,
      required this.jenisAktivitas,
      required this.judul,
      required this.nmrSk,
      required this.lokasi,
      required this.tglSk,
      required this.ketKegiatan,
      required this.prodi});

  PendidikanPengujian.fromJson(Map<String, dynamic> json) {
    semester = json['semester'] != null ? json['semester'] : '-';
    jenisAktivitas =
        json['jenis_aktivitas'] != null ? json['jenis_aktivitas'] : '-';
    judul = json['judul'] != null ? json['judul'] : '-';
    nmrSk = json['nmr_sk'] != null ? json['nmr_sk'] : '-';
    lokasi = json['lokasi'] != null ? json['lokasi'] : '-';
    tglSk = json['tgl_sk'] != null ? json['tgl_sk'] : '-';
    ketKegiatan = json['ket_kegiatan'] != null ? json['ket_kegiatan'] : '-';
    prodi = Prodi.fromJson(json['prodi']);
  }
  @override
  List<Object?> get props => [
        semester,
        jenisAktivitas,
        judul,
        nmrSk,
        lokasi,
        tglSk,
        ketKegiatan,
        prodi
      ];
}

class Prodi extends Equatable {
  late final String nama;
  late final String jenjangDidik;

  Prodi({required this.nama, required this.jenjangDidik});

  Prodi.fromJson(Map<String, dynamic> json) {
    nama = json['nama'] != null ? json['nama'] : '-';
    jenjangDidik = json['jenjang_didik'] != null ? json['jenjang_didik'] : '-';
  }
  @override
  List<Object?> get props => [nama, jenjangDidik];
}
