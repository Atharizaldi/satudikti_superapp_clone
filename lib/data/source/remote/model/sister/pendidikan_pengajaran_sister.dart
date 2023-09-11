import 'package:equatable/equatable.dart';

class PendidikanPengajaranSister extends Equatable {
  late final String message;
  late final int status;
  late final List<PendidikanPengajaran> pendidikanPengajaran;

  PendidikanPengajaranSister(
      {required this.message,
      required this.status,
      required this.pendidikanPengajaran});

  PendidikanPengajaranSister.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    pendidikanPengajaran = List.from(json['data'])
        .map((e) => PendidikanPengajaran.fromJson(e))
        .toList();
  }
  @override
  List<Object?> get props => [message, status, pendidikanPengajaran];
}

class PendidikanPengajaran extends Equatable {
  late final String semester;
  late final String perguruanTinggi;
  late final String namaMk;
  late final String kelas;
  late final String jmlMhs;
  late final Unit unit;
  late final String sksAjar;

  PendidikanPengajaran(
      {required this.semester,
      required this.perguruanTinggi,
      required this.namaMk,
      required this.kelas,
      required this.jmlMhs,
      required this.unit,
      required this.sksAjar});

  PendidikanPengajaran.fromJson(Map<String, dynamic> json) {
    semester = json['semester'] != null ? json['semester'] : "-";
    perguruanTinggi =
        json['perguruan_tinggi'] != null ? json['perguruan_tinggi'] : '-';
    namaMk = json['nama_mk'] != null ? json['nama_mk'] : '-';
    kelas = json['kelas'] != null ? json['kelas'] : '-';
    jmlMhs = json['jml_mhs'] != null ? json['jml_mhs'] : '-';
    unit = Unit.fromJson(json['unit']);
    sksAjar = json['sks_ajar'] != null ? json['sks_ajar'] : '-';
  }

  @override
  List<Object?> get props =>
      [semester, perguruanTinggi, namaMk, kelas, jmlMhs, unit, sksAjar];
}

class Unit extends Equatable {
  late final String nama;
  late final String jenjangDidik;

  Unit({required this.nama, required this.jenjangDidik});

  Unit.fromJson(Map<String, dynamic> json) {
    nama = json['nama'] != null ? json['nama'] : '-';
    jenjangDidik = json['jenjang_didik'] != null ? json['jenjang_didik'] : '-';
  }
  @override
  List<Object?> get props => [nama, jenjangDidik];
}
