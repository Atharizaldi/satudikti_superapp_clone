import 'package:equatable/equatable.dart';

class PendidikanFormalDosenSister extends Equatable {
  late final String message;
  late final int status;
  late final List<PendidikanFormalDosen> pendidikanFormalDosen;

  PendidikanFormalDosenSister(
      {required this.message,
      required this.status,
      required this.pendidikanFormalDosen});

  PendidikanFormalDosenSister.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];

    pendidikanFormalDosen = List.from(json['data'])
        .map((e) => PendidikanFormalDosen.fromJson(e))
        .toList();
  }
  @override
  List<Object?> get props => [message, status, pendidikanFormalDosen];
}

class PendidikanFormalDosen extends Equatable {
  late final String jenjangDidik;
  late final String gelar;
  late final String bidangStudi;
  late final String perguruanTinggi;
  late final int tahunLulus;

  PendidikanFormalDosen(
      {required this.jenjangDidik,
      required this.gelar,
      required this.bidangStudi,
      required this.perguruanTinggi,
      required this.tahunLulus});

  PendidikanFormalDosen.fromJson(Map<String, dynamic> json) {
    jenjangDidik = json['jenjang_didik'];
    gelar = json['gelar'];
    bidangStudi = json['bidang_studi'];
    perguruanTinggi = json['perguruan_tinggi'];
    tahunLulus = json['tahun_lulus'];
  }

  @override
  List<Object?> get props =>
      [jenjangDidik, gelar, bidangStudi, perguruanTinggi, tahunLulus];
}
