import 'package:equatable/equatable.dart';

class PendidikanDiklatSister extends Equatable {
  late final String message;
  late final int status;
  late final List<PendidikanDiklat> pendidikanDiklat;

  PendidikanDiklatSister(
      {required this.message,
      required this.status,
      required this.pendidikanDiklat});

  PendidikanDiklatSister.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    pendidikanDiklat = List.from(json['data'])
        .map((e) => PendidikanDiklat.fromJson(e))
        .toList();
  }
  @override
  List<Object?> get props => [message, status, pendidikanDiklat];
}

class PendidikanDiklat extends Equatable {
  late final String nama;
  late final String jenis;
  late final String penyelenggara;
  late final int tahun;

  PendidikanDiklat(
      {required this.nama,
      required this.jenis,
      required this.penyelenggara,
      required this.tahun});

  PendidikanDiklat.fromJson(Map<String, dynamic> json) {
    nama = json['nama'];
    jenis = json['jenis'];
    penyelenggara = json['penyelenggara'];
    tahun = json['tahun'];
  }
  @override
  List<Object?> get props => [nama, jenis, penyelenggara, tahun];
}
