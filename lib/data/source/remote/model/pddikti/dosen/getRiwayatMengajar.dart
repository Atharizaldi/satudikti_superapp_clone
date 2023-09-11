import 'package:collection/collection.dart';

class RiwayatMengajar {
  RiwayatMengajar({
    required this.data,
    required this.message,
  });
  late final Data data;
  late final String message;
  
  RiwayatMengajar.fromJson(Map<String, dynamic> json){
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
    other is RiwayatMengajar &&
    data == other.data &&
    message == other.message;

  @override
  int get hashCode => Object.hash( data, message);

}

class Data {
  Data({
    required this.riwayat,
  });
  late final List<Riwayat> riwayat;
  
  Data.fromJson(Map<String, dynamic> json){
    riwayat = List.from(json['riwayat']).map((e)=>Riwayat.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['riwayat'] = riwayat.map((e)=>e.toJson()).toList();
    return _data;
  }

  @override
  bool operator ==(Object other) {
    return other is Data &&
    IterableEquality().equals(riwayat, other.riwayat);
  }
  @override
  int get hashCode {
    return const IterableEquality().hash(riwayat);
  }

}

class Riwayat {
  Riwayat({
    required this.id,
    required this.semester,
    required this.kodeMk,
    required this.namaMk,
    required this.sksAjar,
    required this.kelas,
    required this.pt,
    required this.prodi,
  });
  late final String id;
  late final int semester;
  late final String kodeMk;
  late final String namaMk;
  late final String sksAjar;
  late final String kelas;
  late final Pt pt;
  late final Prodi prodi;
  
  Riwayat.fromJson(Map<String, dynamic> json){
    id = json['id'];
    semester = json['semester'];
    kodeMk = json['kode_mk'];
    namaMk = json['nama_mk'];
    sksAjar = json['sks_ajar'];
    kelas = json['kelas'];
    pt = Pt.fromJson(json['pt']);
    prodi = Prodi.fromJson(json['prodi']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['semester'] = semester;
    _data['kode_mk'] = kodeMk;
    _data['nama_mk'] = namaMk;
    _data['sks_ajar'] = sksAjar;
    _data['kelas'] = kelas;
    _data['pt'] = pt.toJson();
    _data['prodi'] = prodi.toJson();
    return _data;
  }

  @override
  bool operator ==(Object other) =>
    other is Riwayat &&
    id == other.id &&
    semester == other.semester &&
    kodeMk == other.kodeMk &&
    namaMk == other.namaMk &&
    sksAjar == other.sksAjar &&
    kelas == other.kelas &&
    pt == other.pt &&
    prodi == other.prodi;

  @override
  int get hashCode => Object.hash( id, semester, kodeMk, namaMk, sksAjar, kelas, pt, prodi);

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
  bool operator ==(Object other) =>
    other is Pt &&
    id == other.id &&
    kode == other.kode &&
    nama == other.nama;

  @override
  int get hashCode => Object.hash( id, kode, nama);

}

class Prodi {
  Prodi({
    required this.id,
    required this.kode,
    required this.nama,
    required this.jenjangDidik,
  });
  late final String id;
  late final String kode;
  late final String nama;
  late final JenjangDidik jenjangDidik;
  
  Prodi.fromJson(Map<String, dynamic> json){
    id = json['id'];
    kode = json['kode'];
    nama = json['nama'];
    jenjangDidik = JenjangDidik.fromJson(json['jenjang_didik']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['kode'] = kode;
    _data['nama'] = nama;
    _data['jenjang_didik'] = jenjangDidik.toJson();
    return _data;
  }

  @override
  bool operator ==(Object other) =>
    other is Prodi &&
    id == other.id &&
    kode == other.kode &&
    nama == other.nama &&
    jenjangDidik == other.jenjangDidik;

  @override
  int get hashCode => Object.hash( id, kode, nama, jenjangDidik);

}

class JenjangDidik {
  JenjangDidik({
    required this.id,
    required this.nama,
  });
  late final int id;
  late final String nama;
  
  JenjangDidik.fromJson(Map<String, dynamic> json){
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
    other is JenjangDidik &&
    id == other.id &&
    nama == other.nama;

  @override
  int get hashCode => Object.hash( id, nama);

}