import 'dart:convert';

import 'package:collection/collection.dart';

enum TagBeasiswa {
  umum,
  mahasiswa,
  dosen,
}

extension ParseToString on TagBeasiswa {
  String toShortString() {
    return this.toString().split('.').last;
  }
}

Beasiswa beasiswaFromJson(String str) => Beasiswa.fromJson(json.decode(str));

String beasiswaToJson(Beasiswa data) => json.encode(data.toJson());

class Beasiswa {
  Beasiswa({
    this.data,
    required this.message,
  });

  Data? data;
  String message;

  factory Beasiswa.fromJson(Map<String, dynamic> json) => Beasiswa(
    data: Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data!.toJson(),
    "message": message,
  };

  @override
  bool operator ==(Object other) =>
      other is Beasiswa && message == other.message && data == other.data;

  @override
  int get hashCode => Object.hash(data, message);

}

class Data {
  Data({
    required this.page,
    required this.pages,
    required this.rowCount,
    required this.limit,
    required this.listBeasiswa,
  });

  int page;
  int pages;
  int rowCount;
  int limit;
  List<ListBeasiswa> listBeasiswa;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    page: json["page"],
    pages: json["pages"],
    rowCount: json["row_count"],
    limit: json["limit"],
    listBeasiswa: List<ListBeasiswa>.from(
        json["list_beasiswa"].map((x) => ListBeasiswa.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "pages": pages,
    "row_count": rowCount,
    "limit": limit,
    "list_beasiswa":
    List<dynamic>.from(listBeasiswa.map((x) => x.toJson())),
  };

  @override
  bool operator ==(Object other) =>
     other is Data &&
        page == other.page &&
        pages == other.pages &&
        rowCount == other.rowCount &&
        limit == other.limit &&
        IterableEquality().equals(listBeasiswa, other.listBeasiswa);
  @override
  int get hashCode => Object.hash(page,pages,rowCount,limit);

}

class ListBeasiswa {
  ListBeasiswa({
    required this.id,
    required this.nama,
    required this.slug,
    required this.penerima,
    required this.deskripsi,
    required this.penyelenggara,
    required this.persyaratan,
    required this.linkPendaftaran,
    required this.tanggalDibuka,
    required this.tanggalDitutup,
    required this.isOpen,
    required this.isPublished,
    required this.lampiran,
    required this.status,
  });

  String id;
  String nama;
  String slug;
  List<Penerima> penerima;
  String deskripsi;
  String penyelenggara;
  String persyaratan;
  String linkPendaftaran;
  DateTime tanggalDibuka;
  DateTime tanggalDitutup;
  bool isOpen;
  bool isPublished;
  Lampiran? lampiran;
  String status;

  factory ListBeasiswa.fromJson(Map<String, dynamic> json) => ListBeasiswa(
    id: json["id"],
    nama: json["nama"],
    slug: json["slug"],
    penerima: List<Penerima>.from(
        json["penerima"].map((x) => Penerima.fromJson(x))),
    deskripsi: json["deskripsi"],
    penyelenggara: json["penyelenggara"],
    persyaratan: json["persyaratan"],
    linkPendaftaran: json["link_pendaftaran"],
    tanggalDibuka: DateTime.parse(json["tanggal_dibuka"]),
    tanggalDitutup: DateTime.parse(json["tanggal_ditutup"]),
    isOpen: json["is_open"],
    isPublished : json["is_published"],
    lampiran : Lampiran.fromJson(json['lampiran']),
    status: json["status"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nama": nama,
    "slug": slug,
    "penerima": List<dynamic>.from(penerima.map((x) => x.toJson())),
    "deskripsi": deskripsi,
    "penyelenggara": penyelenggara,
    "persyaratan": persyaratan,
    "link_pendaftaran": linkPendaftaran,
    "tanggal_dibuka":
    "${tanggalDibuka.year.toString().padLeft(4, '0')}-${tanggalDibuka.month.toString().padLeft(2, '0')}-${tanggalDibuka.day.toString().padLeft(2, '0')}",
    "tanggal_ditutup":
    "${tanggalDitutup.year.toString().padLeft(4, '0')}-${tanggalDitutup.month.toString().padLeft(2, '0')}-${tanggalDitutup.day.toString().padLeft(2, '0')}",
    "is_open": isOpen,
  };
  @override
  bool operator ==(Object other) =>
  other is ListBeasiswa &&
        id == other.id &&
        nama == other.nama &&
        slug == other.slug &&
        IterableEquality().equals(penerima, other.penerima) &&
        deskripsi == other.deskripsi &&
        penyelenggara == other.penyelenggara &&
        persyaratan == other.persyaratan &&
        linkPendaftaran == other.linkPendaftaran &&
        tanggalDibuka == other.tanggalDibuka &&
        tanggalDitutup == other.tanggalDitutup &&
        isOpen == other.isOpen;

  @override
  int get hashCode => Object.hash(id, nama, slug, deskripsi, penyelenggara,
  persyaratan, linkPendaftaran, tanggalDibuka, tanggalDitutup, isOpen);

}

class Penerima {
  Penerima({
    required this.id,
    required this.nama,
  });

  String id;
  String nama;

  factory Penerima.fromJson(Map<String, dynamic> json) => Penerima(
    id: json["id"],
    nama: json["nama"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nama": nama,
  };

  @override
  bool operator ==(Object other) =>
     other is Penerima && id == other.id && nama == other.nama;
  @override
  int get hashCode => Object.hash(
      id, nama);

}

class Lampiran {

  Lampiran({
    required this.id,
    required this.pathFile,
});
  String id;
  String pathFile;

  factory Lampiran.fromJson(Map<String, dynamic> json) => Lampiran(
    id: json["id"],
    pathFile: json["path_file"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "path_file": pathFile,
  };

  @override
  bool operator ==(Object other) =>
      other is Lampiran && id == other.id && pathFile == other.pathFile;
  @override
  int get hashCode => Object.hash(
     id, pathFile);

}