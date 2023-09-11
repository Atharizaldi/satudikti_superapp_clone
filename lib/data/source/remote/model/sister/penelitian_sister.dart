import 'package:equatable/equatable.dart';

class PenelitianSister extends Equatable {
  late final String message;
  late final List<PenelitianData> penelitianData;
  late final List<Publikasi> publikasi;

  PenelitianSister(
      {required this.message,
      required this.penelitianData,
      required this.publikasi});

  PenelitianSister.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    penelitianData = List.from(json['data']['penelitian'])
        .map((e) => PenelitianData.fromJson(e))
        .toList();

    publikasi = List.from(json['data']['publikasi'])
        .map((e) => Publikasi.fromJson(e))
        .toList();
  }
  @override
  List<Object?> get props => [message, penelitianData, publikasi];
}

class PenelitianData extends Equatable {
  late final String judul;
  late final int tahunPelaksanaanKe;
  late final String peran;
  late final String lokasiKegiatan;

  PenelitianData(
      {required this.judul,
      required this.tahunPelaksanaanKe,
      required this.peran,
      required this.lokasiKegiatan});

  PenelitianData.fromJson(Map<String, dynamic> json) {
    judul = json['judul'] != null ? json['judul'] : '-';
    tahunPelaksanaanKe =
        json['tahun_kegiatan'] != null ? json['tahun_kegiatan'] : 0;
    peran = json['peran'] != null ? json['peran'] : '-';
    lokasiKegiatan =
        json['lokasi-kegiatan'] != null ? json['lokasi-kegiatan'] : '-';
  }
  @override
  List<Object?> get props => [judul, tahunPelaksanaanKe, peran, lokasiKegiatan];
}

class Publikasi extends Equatable {
  late final String judul;
  late final String namaJurnal;
  late final String kategoriKegiatan;
  late final String jenisPublikasi;
  late final String tanggalTerbit;
  late final String peran;
  late final String asalData;

  Publikasi(
      {required this.judul,
      required this.namaJurnal,
      required this.kategoriKegiatan,
      required this.jenisPublikasi,
      required this.tanggalTerbit,
      required this.peran,
      required this.asalData});

  Publikasi.fromJson(Map<String, dynamic> json) {
    judul = json['judul'] ?? '-';
    namaJurnal = json['nama_jurnal'] ?? '-';
    kategoriKegiatan = json['kategori_kegiatan'] ?? '-';
    jenisPublikasi = json['jenis_publikasi'] ?? '-';
    tanggalTerbit = json['tanggal_terbit'] ?? '-';
    peran = json['peran'] ?? '-';
    asalData = json['asal_data'] ?? '-';
  }
  @override
  List<Object?> get props => [
        judul,
        namaJurnal,
        kategoriKegiatan,
        jenisPublikasi,
        tanggalTerbit,
        peran,
        asalData
      ];
}
