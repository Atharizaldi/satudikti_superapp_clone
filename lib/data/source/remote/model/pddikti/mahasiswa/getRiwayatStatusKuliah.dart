import 'package:collection/collection.dart';

class RiwayatStatusKuliah {
  RiwayatStatusKuliah({
    required this.data,
    required this.message,
  });
  late final Data data;
  late final String message;
  
  RiwayatStatusKuliah.fromJson(Map<String, dynamic> json){
    data = Data.fromJson(json['data']);
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.toJson();
    _data['message'] = message;
    return _data;
  }

  @override
  bool operator ==(Object other) =>
     other is RiwayatStatusKuliah &&
    data == other.data &&
    message == other.message;

  @override
  int get hashCode => Object.hash( data, message);
}

class Data {
  Data({
    required this.mahasiswa,
  });
  late final List<Mahasiswa> mahasiswa;
  
  Data.fromJson(Map<String, dynamic> json){
    mahasiswa = List.from(json['mahasiswa']).map((e)=>Mahasiswa.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['mahasiswa'] = mahasiswa.map((e)=>e.toJson()).toList();
    return _data;
  }

  @override
  bool operator ==(Object other) {
    return other is Data &&
    IterableEquality().equals(mahasiswa, other.mahasiswa);
  }
  @override
  int get hashCode {
    return const IterableEquality().hash(mahasiswa);
  }

}

class Mahasiswa {
  Mahasiswa({
    required this.semester,
    required this.statusAktif,
    required this.sks,
  });
  late final Semester semester;
  late final StatusAktif statusAktif;
  late final int sks;
  
  Mahasiswa.fromJson(Map<String, dynamic> json){
    semester = Semester.fromJson(json['semester']);
    statusAktif = StatusAktif.fromJson(json['status_aktif']);
    sks = json['sks'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['semester'] = semester.toJson();
    _data['status_aktif'] = statusAktif.toJson();
    _data['sks'] = sks;
    return _data;
  }

  @override
  bool operator ==(Object other) =>
     other is Mahasiswa &&
    semester == other.semester &&
    statusAktif == other.statusAktif &&
    sks == other.sks;

  @override
  int get hashCode => Object.hash( semester, statusAktif, sks);
}

class Semester {
  Semester({
    required this.id,
    required this.nama,
  });
  late final int id;
  late final String nama;
  
  Semester.fromJson(Map<String, dynamic> json){
    id = json['id'];
    nama = json['nama'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['nama'] = nama;
    return _data;
  }

  @override
  bool operator ==(Object other) =>
     other is Semester &&
    id == other.id &&
    nama == other.nama;

  @override
  int get hashCode => Object.hash( id, nama);
}

class StatusAktif {
  StatusAktif({
    required this.id,
    required this.nama,
  });
  late final String id;
  late final String nama;
  
  StatusAktif.fromJson(Map<String, dynamic> json){
    id = json['id'];
    nama = json['nama'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['nama'] = nama;
    return _data;
  }

  @override
  bool operator ==(Object other) =>
     other is StatusAktif &&
    id == other.id &&
    nama == other.nama;

  @override
  int get hashCode => Object.hash( id, nama);
}