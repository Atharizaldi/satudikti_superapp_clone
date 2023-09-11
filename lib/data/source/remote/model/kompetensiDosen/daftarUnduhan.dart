import 'package:app/common/utils.dart';

class DaftarUnduhanResponse {
  final DataDaftarUnduhan? data;
  final String? message;

  DaftarUnduhanResponse({this.data, this.message});

  factory DaftarUnduhanResponse.fromJson(Map<String, dynamic> json) =>
      DaftarUnduhanResponse(
          data: DataDaftarUnduhan.fromJson(json['data']),
          message: json['message']);
}

class DataDaftarUnduhan {
  final List<DaftarUnduhan>? listDaftarUnduhan;

  DataDaftarUnduhan({this.listDaftarUnduhan});
  factory DataDaftarUnduhan.fromJson(List<dynamic> json) => DataDaftarUnduhan(
      listDaftarUnduhan: json.map((e) => DaftarUnduhan.fromJson(e)).toList());
}

class DaftarUnduhan {
  final String? id, name, date, url;

  DaftarUnduhan({this.id, this.name, this.date, this.url});
  factory DaftarUnduhan.fromJson(Map<String, dynamic> json) => DaftarUnduhan(
        id: json['id'],
        name: json['judul_file'],
        date: json['created_at'],
        url: retrieveLastSegmentOfUrl(json['url']),
      );

  @override
  bool operator ==(Object other) =>
     other is DaftarUnduhan &&
        this.id == other.id &&
        this.name == other.name &&
        this.date == other.date &&
        this.url == other.url;

  @override
  int get hashCode => Object.hash(
      id, name, date, url);

}

List<DaftarUnduhan> dummyListDaftarUnduhan = [
  DaftarUnduhan(
      id: "1",
      name:
          "Bisnis Terampil  Pengelolaan Keuangan Panjang banget, jika ditulis di judul penelitianaskajskjalajska",
      date: "2022-06-11T19:19:23Z"),
  DaftarUnduhan(
      id: "2",
      name:
          "Bisnis Terampil  Pengelolaan Keuangan Panjang banget, jika ditulis di judul penelitianaskajskjalajska",
      date: "2022-06-11T19:19:23Z"),
  DaftarUnduhan(
      id: "3",
      name:
          "Bisnis Terampil  Pengelolaan Keuangan Panjang banget, jika ditulis di judul penelitianaskajskjalajska",
      date: "2022-06-11T19:19:23Z"),
  DaftarUnduhan(
      id: "4",
      name:
          "Bisnis Terampil  Pengelolaan Keuangan Panjang banget, jika ditulis di judul penelitianaskajskjalajska",
      date: "2022-06-11T19:19:23Z"),
  DaftarUnduhan(
      id: "5",
      name:
          "Bisnis Terampil  Pengelolaan Keuangan Panjang banget, jika ditulis di judul penelitianaskajskjalajska",
      date: "2022-06-11T19:19:23Z"),
  DaftarUnduhan(
      id: "6",
      name:
          "Bisnis Terampil  Pengelolaan Keuangan Panjang banget, jika ditulis di judul penelitianaskajskjalajska",
      date: "2022-06-11T19:19:23Z"),
];
