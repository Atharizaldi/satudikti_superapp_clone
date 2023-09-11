import 'package:collection/collection.dart';

class GetListProdi {
  GetListProdi({
    required this.data,
    required this.message,
  });
  late final Data data;
  late final String message;

  GetListProdi.fromJson(Map<String, dynamic> json) {
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
     other is GetListProdi &&
    data == other.data &&
    message == other.message;

  @override
  int get hashCode => Object.hash( data, message);
}

class Data {
  Data({
    required this.prodi,
  });
  late final List<Prodi> prodi;

  Data.fromJson(Map<String, dynamic> json) {
    prodi = List.from(json['prodi']).map((e) => Prodi.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['prodi'] = prodi.map((e) => e.toJson()).toList();
    return _data;
  }

  @override
  bool operator ==(Object other) {
    return other is Data &&
    IterableEquality().equals(prodi, other.prodi);
  }
  @override
  int get hashCode {
    return const IterableEquality().hash(prodi);
  }
}

class Prodi {
  Prodi({
    required this.id,
    required this.kode,
    required this.nama,
    required this.status,
    required this.akreditasi,
    required this.jenjangDidik,
    required this.pt,
  });
  late final String id;
  late final String kode;
  late final String nama;
  late final String status;
  late final String akreditasi;
  late final JenjangDidik jenjangDidik;
  late final Pt pt;

  Prodi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kode = json['kode'];
    nama = json['nama'];
    status = json['status'];
    akreditasi = json['akreditasi'];
    jenjangDidik = JenjangDidik.fromJson(json['jenjang_didik']);
    pt = Pt.fromJson(json['pt']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['kode'] = kode;
    _data['nama'] = nama;
    _data['status'] = status;
    _data['akreditasi'] = akreditasi;
    _data['jenjang_didik'] = jenjangDidik.toJson();
    _data['pt'] = pt.toJson();
    return _data;
  }

  @override
  bool operator ==(Object other) =>
    other is Prodi &&
    id == other.id &&
    kode == other.kode &&
    nama == other.nama &&
    status == other.status &&
    akreditasi == other.akreditasi &&
    jenjangDidik == other.jenjangDidik &&
    pt == other.pt;

  @override
  int get hashCode => Object.hash( id, kode, nama, status, akreditasi, jenjangDidik, pt);

}

class JenjangDidik {
  JenjangDidik({
    required this.id,
    required this.nama,
  });
  late final int id;
  late final String nama;

  JenjangDidik.fromJson(Map<String, dynamic> json) {
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
    return other is JenjangDidik &&
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

  Pt.fromJson(Map<String, dynamic> json) {
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
