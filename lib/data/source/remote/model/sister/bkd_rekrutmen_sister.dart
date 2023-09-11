import 'package:equatable/equatable.dart';

class BKDRekrutmenSister extends Equatable {
  late final String message;
  late final int status;
  late final List<BKDRekrutmenData> bkdRekrutmenData;

  BKDRekrutmenSister(
      {required this.message,
      required this.status,
      required this.bkdRekrutmenData});

  BKDRekrutmenSister.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    bkdRekrutmenData = List.from(json['data'])
        .map((e) => BKDRekrutmenData.fromJson(e))
        .toList();
  }
  @override
  List<Object?> get props => [message, status, bkdRekrutmenData];
}

class BKDRekrutmenData extends Equatable {
  late final String nama;
  late final String tglAwal;
  late final String tglAkhir;
  late final int nilaiCat;
  late final int nilaiKeterangan;
  late final String serdik;
  late final String nira;
  late final String cetak;

  BKDRekrutmenData(
      {required this.nama,
      required this.tglAwal,
      required this.tglAkhir,
      required this.nilaiCat,
      required this.nilaiKeterangan,
      required this.serdik,
      required this.nira,
      required this.cetak});

  BKDRekrutmenData.fromJson(Map<String, dynamic> json) {
    nama = json['nama'] != null ? json['nama'] : '-';
    tglAwal = json['tgl_awal'] != null ? json['tgl_awal'] : '-';
    tglAkhir = json['tgl_akhir'] != null ? json['tgl_akhir'] : '-';
    nilaiCat = json['nilai_cat'] != null ? json['nilai_cat'] : 0;
    nilaiKeterangan =
        json['nilai_keterangan'] != null ? json['nilai_keterangan'] : 0;
    serdik = json['serdik'] != null ? json['serdik'] : '-';
    nira = json['nira'] != null ? json['nira'] : "-";
    cetak = json['cetak'] != null ? json['cetak'] : '-';
  }
  @override
  List<Object?> get props =>
      [nama, tglAwal, tglAkhir, nilaiCat, nilaiKeterangan, serdik, nira, cetak];
}

class BKDPenilaianSister extends Equatable {
  late final String message;
  late final int status;
  late final List<BKDPenilaianData> bkdPenilaianData;

  BKDPenilaianSister(
      {required this.message,
      required this.status,
      required this.bkdPenilaianData});

  BKDPenilaianSister.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    bkdPenilaianData = List.from(json['data'])
        .map((e) => BKDPenilaianData.fromJson(e))
        .toList();
  }
  @override
  List<Object?> get props => [message, status, bkdPenilaianData];
}

class BKDPenilaianData extends Equatable {
  late final String semester;
  late final String namaNidn;
  late final String namaPt;
  late final String namaProdi;
  late final int urutan;
  late final String tglPengesahan;

  BKDPenilaianData(
      {required this.semester,
      required this.namaNidn,
      required this.namaPt,
      required this.namaProdi,
      required this.urutan,
      required this.tglPengesahan});

  BKDPenilaianData.fromJson(Map<String, dynamic> json) {
    semester = json['semester'] != null ? json['semester'] : '-';
    namaNidn = json['nama_nidn'] != null ? json['nama_nidn'] : '-';
    namaPt = json['nama_pt'] != null ? json['nama_pt'] : '-';
    namaProdi = json['nama_prodi'] != null ? json['nama_prodi'] : '-';
    urutan = json['urutan'] != null ? json['urutan'] : 0;
    tglPengesahan =
        json['tgl_pengesahan'] != null ? json['tgl_pengesahan'] : '-';
  }
  @override
  List<Object?> get props =>
      [semester, namaNidn, namaPt, namaProdi, urutan, tglPengesahan];
}
