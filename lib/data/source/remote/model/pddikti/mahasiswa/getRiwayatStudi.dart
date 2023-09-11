import 'package:collection/collection.dart';

class RiwayatStudiMahasiswa {
  RiwayatStudiMahasiswa({
    required this.data,
    required this.message,
  });
  late final Data data;
  late final String message;
  
  RiwayatStudiMahasiswa.fromJson(Map<String, dynamic> json){
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
     other is RiwayatStudiMahasiswa &&
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
    required this.kodeMk,
    required this.namaMk,
    required this.sks,
    required this.semester,
    required this.pt,
    required this.prodi,
  });
  late final String kodeMk;
  late final String namaMk;
  late final String sks;
  late final Semester semester;
  late final Pt pt;
  late final Prodi prodi;
  
  Mahasiswa.fromJson(Map<String, dynamic> json){
    kodeMk = json['kode_mk'];
    namaMk = json['nama_mk'];
    sks = json['sks'];
    semester = Semester.fromJson(json['semester']);
    pt = Pt.fromJson(json['pt']);
    prodi = Prodi.fromJson(json['prodi']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['kode_mk'] = kodeMk;
    _data['nama_mk'] = namaMk;
    _data['sks'] = sks;
    _data['semester'] = semester.toJson();
    _data['pt'] = pt.toJson();
    _data['prodi'] = prodi.toJson();
    return _data;
  }

  @override
  bool operator ==(Object other) =>
     other is Mahasiswa &&
    kodeMk == other.kodeMk &&
    namaMk == other.namaMk &&
    sks == other.sks &&
    semester == other.semester &&
    pt == other.pt &&
    prodi == other.prodi;

  @override
  int get hashCode => Object.hash( kodeMk, namaMk, sks, semester, pt, prodi );
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
  bool operator ==(Object other) {
    return other is Semester &&
    id == other.id &&
    nama == other.nama;
  }
  @override
  int get hashCode {
    return id.hashCode ^ nama.hashCode;
  }
}

class Pt {
  Pt({
    required this.id,
    required this.kode,
    required this.nama,
  });
  late final String id;
  late final String kode;
  late final String nama;
  
  Pt.fromJson(Map<String, dynamic> json){
    id = json['id'];
    kode = json['kode'];
    nama = json['nama'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['kode'] = kode;
    _data['nama'] = nama;
    return _data;
  }

  @override
  bool operator ==(Object other) {
    return other is Pt &&
    id == other.id &&
    kode == other.kode &&
    nama == other.nama;
  }
  @override
  int get hashCode {
    return id.hashCode ^ kode.hashCode ^ nama.hashCode;
  }
}

class Prodi {
  Prodi({
    required this.id,
    required this.kode,
    required this.nama,
  });
  late final String id;
  late final String kode;
  late final String nama;
  
  Prodi.fromJson(Map<String, dynamic> json){
    id = json['id'];
    kode = json['kode'];
    nama = json['nama'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['kode'] = kode;
    _data['nama'] = nama;
    return _data;
  }

  @override
  bool operator ==(Object other) {
    return other is Prodi &&
    id == other.id &&
    kode == other.kode &&
    nama == other.nama;
  }
  @override
  int get hashCode {
    return id.hashCode ^ kode.hashCode ^ nama.hashCode;
  }
}