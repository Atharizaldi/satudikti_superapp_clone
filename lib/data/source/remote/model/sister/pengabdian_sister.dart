import 'package:equatable/equatable.dart';

class PengabdianSister extends Equatable {
  late final String message;
  late final List<PengabdianData> pengabdianData;

  PengabdianSister({required this.message, required this.pengabdianData});

  PengabdianSister.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    pengabdianData =
        List.from(json['data']).map((e) => PengabdianData.fromJson(e)).toList();
  }
  @override
  List<Object?> get props => [message, pengabdianData];
}

class PengabdianData extends Equatable {
  late final String judul;
  late final int tahunPelaksanaanKe;
  late final String peran;
  late final String lokasi;

  PengabdianData(
      {required this.judul,
      required this.tahunPelaksanaanKe,
      required this.peran,
      required this.lokasi});

  PengabdianData.fromJson(Map<String, dynamic> json) {
    judul = json['judul'] != null ? json['judul'] : '-';
    tahunPelaksanaanKe =
        json['tahun_kegiatan'] != null ? json['tahun_kegiatan'] : '-';
    peran = json['peran'] != null ? json['peran'] : '-';
    lokasi = json['lokasi'] != null ? json['lokasi'] : '-';
  }
  @override
  List<Object?> get props => [judul, tahunPelaksanaanKe, peran, lokasi];
}
