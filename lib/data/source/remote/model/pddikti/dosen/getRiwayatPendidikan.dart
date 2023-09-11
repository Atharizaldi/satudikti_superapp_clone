import 'package:collection/collection.dart';

class RiwayatPendidikan {
  RiwayatPendidikan({
    required this.data,
    required this.message,
  });
  late final Data data;
  late final String message;
  
  RiwayatPendidikan.fromJson(Map<String, dynamic> json){
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
    other is RiwayatPendidikan &&
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
    required this.pt,
    required this.thnLulus,
    required this.gelar,
    required this.bidangStudi,
    required this.jenjangDidik,
    required this.prodi,
  });
  late final String id;
  late final String pt;
  late final int thnLulus;
  late final Gelar gelar;
  late final BidangStudi bidangStudi;
  late final JenjangDidik jenjangDidik;
  late final Prodi prodi;
  
  Riwayat.fromJson(Map<String, dynamic> json){
    id = json['id'];
    pt = json['pt'];
    thnLulus = json['thn_lulus'];
    gelar = Gelar.fromJson(json['gelar']);
    bidangStudi = BidangStudi.fromJson(json['bidang_studi']);
    jenjangDidik = JenjangDidik.fromJson(json['jenjang_didik']);
    prodi = Prodi.fromJson(json['prodi']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['pt'] = pt;
    _data['thn_lulus'] = thnLulus;
    _data['gelar'] = gelar.toJson();
    _data['bidang_studi'] = bidangStudi.toJson();
    _data['jenjang_didik'] = jenjangDidik.toJson();
    _data['prodi'] = prodi.toJson();
    return _data;
  }

  @override
  bool operator ==(Object other) =>
    other is Riwayat &&
    id == other.id &&
    pt == other.pt &&
    thnLulus == other.thnLulus &&
    gelar == other.gelar &&
    bidangStudi == other.bidangStudi &&
    jenjangDidik == other.jenjangDidik &&
    prodi == other.prodi;

  @override
  int get hashCode => Object.hash( id, pt, thnLulus, gelar, bidangStudi, jenjangDidik, prodi);

}

class Gelar {
  Gelar({
    required this.id,
    required this.nama,
    required this.singkatan,
    required this.posisi,
  });
  late final int id;
  late final String nama;
  late final String singkatan;
  late final int posisi;
  
  Gelar.fromJson(Map<String, dynamic> json){
    id = json['id'];
    nama = json['nama'];
    singkatan = json['singkatan'];
    posisi = json['posisi'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['nama'] = nama;
    _data['singkatan'] = singkatan;
    _data['posisi'] = posisi;
    return _data;
  }

  @override
  bool operator ==(Object other) =>
    other is Gelar &&
    id == other.id &&
    nama == other.nama &&
    singkatan == other.singkatan &&
    posisi == other.posisi;

  @override
  int get hashCode => Object.hash( id, nama, singkatan, posisi);

}

class BidangStudi {
  BidangStudi({
    required this.id,
    required this.nama,
  });
  late final int id;
  late final String nama;
  
  BidangStudi.fromJson(Map<String, dynamic> json){
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
    other is BidangStudi &&
    id == other.id &&
    nama == other.nama;

  @override
  int get hashCode => Object.hash( id, nama);

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
  bool operator ==(Object other) =>
     other is Prodi &&
    id == other.id &&
    kode == other.kode &&
    nama == other.nama;

  @override
  int get hashCode => Object.hash( id, kode, nama);

}