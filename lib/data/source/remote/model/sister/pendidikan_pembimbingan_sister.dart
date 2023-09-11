import 'package:equatable/equatable.dart';

class PendidikanPembimbinganSister extends Equatable {
  late final String message;
  late final int status;
  late final List<PendidikanPembimbingan> pendidikanPembimbingan;

  PendidikanPembimbinganSister(
      {required this.message,
      required this.status,
      required this.pendidikanPembimbingan});

  PendidikanPembimbinganSister.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];

    pendidikanPembimbingan = List.from(json['data'])
        .map((e) => PendidikanPembimbingan.fromJson(e))
        .toList();
  }
  @override
  List<Object?> get props => [message, status, pendidikanPembimbingan];
}

class PendidikanPembimbingan extends Equatable {
  late final String semester;
  late final String jenisAktivitas;
  late final String judul;
  late final String lokasi;
  late final String nmrSk;
  late final String tglSk;
  late final String ketKegiatan;
  late final String katKegiatan;
  late final Prodi prodi;

  PendidikanPembimbingan(
      {required this.semester,
      required this.jenisAktivitas,
      required this.judul,
      required this.lokasi,
      required this.nmrSk,
      required this.tglSk,
      required this.ketKegiatan,
      required this.katKegiatan,
      required this.prodi});

  PendidikanPembimbingan.fromJson(Map<String, dynamic> json) {
    semester = json['semester'] != null ? json['semester'] : '-';
    jenisAktivitas =
        json['jenis_aktivitas'] != null ? json['jenis_aktivitas'] : '-';
    judul = json['judul'] != null ? json['judul'] : '-';
    lokasi = json['lokasi'] != null ? json['lokasi'] : '-';
    nmrSk = json['nmr_sk'] != null ? json['nmr_sk'] : '-';
    tglSk = json['tgl_sk'] != null ? json['tgl_sk'] : '-';
    ketKegiatan = json['ket_kegiatan'] != null ? json['ket_kegiatan'] : '-';
    katKegiatan = json['kat_kegiatan'] != null ? json['kat_kegiatan'] : '-';
    prodi = Prodi.fromJson(json['prodi']);
  }
  @override
  List<Object?> get props => [
        semester,
        jenisAktivitas,
        judul,
        lokasi,
        nmrSk,
        tglSk,
        ketKegiatan,
        katKegiatan,
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
