import 'package:app/common/utils.dart';

class ProgramTerdaftarResponse {
  final DataProgramTerdaftar? data;
  final String? message;

  ProgramTerdaftarResponse({this.data, this.message});

  factory ProgramTerdaftarResponse.fromJson(Map<String, dynamic> json) =>
      ProgramTerdaftarResponse(
          data: DataProgramTerdaftar.fromJson(json['data']),
          message: json['message']);
}

class DataProgramTerdaftar {
  final List<ProgramTerdaftar>? listProgramTerdaftar;

  DataProgramTerdaftar({this.listProgramTerdaftar});
  factory DataProgramTerdaftar.fromJson(List<dynamic> rawList) =>
      DataProgramTerdaftar(
          listProgramTerdaftar: rawList.map((item) {
        return ProgramTerdaftar.fromJson(item);
      }).toList());
}

class ProgramTerdaftar {
  final String? namaPeriode,
      program,
      skema,
      startDate,
      endDate,
      registeredDate,
      urlRiwayatPenilaian,
      urlSertifikat;

  ProgramTerdaftar({
    this.namaPeriode,
    this.program,
    this.skema,
    this.startDate,
    this.endDate,
    this.registeredDate,
    this.urlRiwayatPenilaian,
    this.urlSertifikat,
  });
  factory ProgramTerdaftar.fromJson(Map<String, dynamic> json) =>
      ProgramTerdaftar(
          namaPeriode: json['nm_periode'],
          program: json['program'],
          skema: json['skema'],
          startDate: json['wkt_buka'],
          endDate: json['wkt_tutup'],
          registeredDate: json['wkt_daftar'],
          urlRiwayatPenilaian:
              retrieveLastSegmentOfUrl(json['url_riwayat_penilaian']),
          urlSertifikat: json["url_sertifikat"]);
}

List<ProgramTerdaftar> dummyListProgramTerdaftar = [
  ProgramTerdaftar(
    namaPeriode: "Program Uji Coba Sistem",
    program: "Program Uji Coba",
    skema: "Uji Coba",
    urlRiwayatPenilaian:
        "https://kompetensi.sumberdaya.kemdikbud.go.id/v2/api/program/penilaian/18795",
    startDate: "2022-01-11T19:19:23Z",
    endDate: "2022-01-11T19:19:23Z",
    registeredDate: "2022-01-11T19:19:23Z",
  ),
  // ProgramTerdaftar(
  //   id: "2",
  //   name:
  //       "Bisnis Terampil  Pengelolaan Keuangan Panjang banget, jika ditulis di judul penelitianaskajskjalajska",
  //   status: "Belum Ditentukan",
  //   startDate: "2022-01-11T19:19:23Z",
  //   endDate: "2022-01-11T19:19:23Z",
  //   registeredDate: "2022-01-11T19:19:23Z",
  // ),
  // ProgramTerdaftar(
  //   id: "3",
  //   name:
  //       "Bisnis Terampil  Pengelolaan Keuangan Panjang banget, jika ditulis di judul penelitianaskajskjalajska",
  //   status: "Tidak Lolos",
  //   startDate: "2022-01-11T19:19:23Z",
  //   endDate: "2022-01-11T19:19:23Z",
  //   registeredDate: "2022-01-11T19:19:23Z",
  // ),
  // ProgramTerdaftar(
  //   id: "4",
  //   name:
  //       "Bisnis Terampil  Pengelolaan Keuangan Panjang banget, jika ditulis di judul penelitianaskajskjalajska",
  //   status: "Kode Tidak Valid",
  //   startDate: "2022-01-11T19:19:23Z",
  //   endDate: "2022-01-11T19:19:23Z",
  //   registeredDate: "2022-01-11T19:19:23Z",
  // ),
  // ProgramTerdaftar(
  //   id: "5",
  //   name:
  //       "Bisnis Terampil  Pengelolaan Keuangan Panjang banget, jika ditulis di judul penelitianaskajskjalajska",
  //   status: "Default",
  //   startDate: "2022-01-11T19:19:23Z",
  //   endDate: "2022-01-11T19:19:23Z",
  //   registeredDate: "2022-01-11T19:19:23Z",
  // ),
  // ProgramTerdaftar(
  //   id: "6",
  //   name:
  //       "Bisnis Terampil  Pengelolaan Keuangan Panjang banget, jika ditulis di judul penelitianaskajskjalajska",
  //   status: "Lolos",
  //   startDate: "2022-01-11T19:19:23Z",
  //   endDate: "2022-01-11T19:19:23Z",
  //   registeredDate: "2022-01-11T19:19:23Z",
  // ),
];
