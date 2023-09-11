import 'package:collection/collection.dart';

class UsulanDosenResponse {
  final DataUsulanDosen? data;
  final String? message;

  UsulanDosenResponse({this.data, this.message});

  factory UsulanDosenResponse.fromJson(Map<String, dynamic> json) =>
      UsulanDosenResponse(
          data: DataUsulanDosen.fromJson(json['data']),
          message: json['message']);
  
  @override
  bool operator ==(Object other) =>
     other is UsulanDosenResponse &&
    data == other.data &&
    message == other.message;

  @override
  int get hashCode => Object.hash( data, message);
}

class DataUsulanDosen {
  final List<UsulanDosen>? listUsulanDosen;

  DataUsulanDosen({this.listUsulanDosen});
  factory DataUsulanDosen.fromJson(List<dynamic> rawList) => DataUsulanDosen(
          listUsulanDosen: rawList.map((item) {
        return UsulanDosen.fromJson(item);
      }).toList());
  
  @override
  bool operator ==(Object other) {
    return other is DataUsulanDosen &&
    IterableEquality().equals(listUsulanDosen, other.listUsulanDosen);
  }
  @override
  int get hashCode {
    return const IterableEquality().hash(listUsulanDosen);
  }

}

class UsulanDosen {
  final String? id,
      nip,
      nik,
      nama,
      namaIbuKandung,
      gelarDepan,
      gelarBelakang,
      jenisKelamin,
      tanggalLahir,
      tempatLahir,
      suratTugas,
      tanggalSuratTugas,
      tmtSuratTugas,
      kewarganegaraan,
      catatan,
      jenis,
      status,
      countAjuan,
      idUser,
      dokumenValid,
      tUpdateUser,
      tUpdateIp,
      tUpdateTime,
      tUpdateAct;

  UsulanDosen({
    this.id,
    this.nip,
    this.nik,
    this.nama,
    this.namaIbuKandung,
    this.gelarDepan,
    this.gelarBelakang,
    this.jenisKelamin,
    this.tanggalLahir,
    this.tempatLahir,
    this.suratTugas,
    this.tanggalSuratTugas,
    this.tmtSuratTugas,
    this.kewarganegaraan,
    this.catatan,
    this.jenis,
    this.status,
    this.countAjuan,
    this.idUser,
    this.dokumenValid,
    this.tUpdateUser,
    this.tUpdateIp,
    this.tUpdateTime,
    this.tUpdateAct,
  });
  factory UsulanDosen.fromJson(Map<String, dynamic> json) => UsulanDosen(
        id: json["id"],
        nip: json["nip"],
        nik: json["nik"],
        nama: json["nama"],
        namaIbuKandung: json["nm_ibu_kandung"],
        gelarDepan: json["gelar_depan"],
        gelarBelakang: json["gelar_belakang"],
        jenisKelamin: json["jenis_kelamin"],
        tanggalLahir: json["tgl_lahir"],
        tempatLahir: json["tempat_lahir"],
        suratTugas: json["surat_tugas"],
        tanggalSuratTugas: json["tgl_surat_tugas"],
        tmtSuratTugas: json["tmt_surat_tugas"],
        kewarganegaraan: json["kewarganegaraan"],
        catatan: json["catatan"],
        jenis: json["jenis"],
        status: json["status"],
        countAjuan: json["count_ajuan"],
        idUser: json["id_user"],
        dokumenValid: json["dokumen_valid"],
        tUpdateUser: json["t_updateuser"],
        tUpdateIp: json["t_updateip"],
        tUpdateTime: json["t_update_time"],
        tUpdateAct: json["t_update_act"],
      );
  
  @override
  bool operator ==(Object other) {
    return other is UsulanDosen &&
     id == other.id &&
     nip == other.nip &&
     nik == other.nik &&
     nama == other.nama &&
     namaIbuKandung == other.namaIbuKandung &&
     gelarDepan == other.gelarDepan &&
     gelarBelakang == other.gelarBelakang &&
     jenisKelamin == other.jenisKelamin &&
     tanggalLahir == other.tanggalLahir &&
     tempatLahir == other.tempatLahir &&
     suratTugas == other.suratTugas &&
     tanggalSuratTugas == other.tanggalSuratTugas &&
     tmtSuratTugas == other.tmtSuratTugas &&
     kewarganegaraan == other.kewarganegaraan &&
     catatan == other.catatan &&
     jenis == other.jenis &&
     status == other.status &&
     countAjuan == other.countAjuan &&
     idUser == other.idUser &&
     dokumenValid == other.dokumenValid &&
     tUpdateUser == other.tUpdateUser &&
     tUpdateIp == other.tUpdateIp &&
     tUpdateTime == other.tUpdateTime &&
     tUpdateAct == other.tUpdateAct;
  }

  @override
  int get hashCode {
    return id.hashCode ^
    nip.hashCode ^
    nik.hashCode ^
    nama.hashCode ^
    namaIbuKandung.hashCode ^
    gelarDepan.hashCode ^
    gelarBelakang.hashCode ^
    jenisKelamin.hashCode ^
    tanggalLahir.hashCode ^
    tempatLahir.hashCode ^
    suratTugas.hashCode ^
    tanggalSuratTugas.hashCode ^
    tmtSuratTugas.hashCode ^
    kewarganegaraan.hashCode ^
    catatan.hashCode ^
    jenis.hashCode ^
    status.hashCode ^
    countAjuan.hashCode ^
    idUser.hashCode ^
    dokumenValid.hashCode ^
    tUpdateUser.hashCode ^
    tUpdateIp.hashCode ^
    tUpdateTime.hashCode ^
    tUpdateAct.hashCode;
  }

}

// List<UsulanDosen> dummyListUsulanDosen = [
//   UsulanDosen(
//     namaPeriode: "Program Uji Coba Sistem",
//     program: "Program Uji Coba",
//     skema: "Uji Coba",
//     urlRiwayatPenilaian:
//         "https://kompetensi.sumberdaya.kemdikbud.go.id/v2/api/program/penilaian/18795",
//     startDate: "2022-01-11T19:19:23Z",
//     endDate: "2022-01-11T19:19:23Z",
//     registeredDate: "2022-01-11T19:19:23Z",
//   ),
// ];
