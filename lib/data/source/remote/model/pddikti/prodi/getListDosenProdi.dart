import 'package:collection/collection.dart';

class GetListDosenProdi {
  GetListDosenProdi({
    required this.data,
    required this.message,
  });
  late final Data data;
  late final String message;

  GetListDosenProdi.fromJson(Map<String, dynamic> json) {
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
     other is GetListDosenProdi &&
        data == other.data &&
        message == other.message;

  @override
  int get hashCode => Object.hash( data, message);
}

class Data {
  Data({
    required this.dosen,
  });
  late final List<Dosen> dosen;

  Data.fromJson(Map<String, dynamic> json) {
    dosen = List.from(json['dosen']).map((e) => Dosen.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['dosen'] = dosen.map((e) => e.toJson()).toList();
    return _data;
  }

  @override
  bool operator ==(Object other) {
    return other is Data && IterableEquality().equals(dosen, other.dosen);
  }
  @override
  int get hashCode {
    return const IterableEquality().hash(dosen);
  }

}

class Dosen {
  Dosen({
    required this.id,
    required this.nidn,
    required this.nama,
    required this.gelarDepan,
    required this.gelarBelakang,
    required this.pendidikanTerakhir,
  });
  late final String id;
  late final String nidn;
  late final String nama;
  late final String gelarDepan;
  late final String gelarBelakang;
  late final String pendidikanTerakhir;

  Dosen.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nidn = json['nidn'];
    nama = json['nama'];
    gelarDepan = json['gelar_depan'];
    gelarBelakang = json['gelar_belakang'];
    pendidikanTerakhir = json['pendidikan_terakhir'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['nidn'] = nidn;
    _data['nama'] = nama;
    _data['gelar_depan'] = gelarDepan;
    _data['gelar_belakang'] = gelarBelakang;
    _data['pendidikan_terakhir'] = pendidikanTerakhir;
    return _data;
  }

  @override
  bool operator ==(Object other) =>
     other is Dosen &&
        id == other.id &&
        nidn == other.nidn &&
        nama == other.nama &&
        gelarDepan == other.gelarDepan &&
        gelarBelakang == other.gelarBelakang &&
        pendidikanTerakhir == other.pendidikanTerakhir;

  @override
  int get hashCode => Object.hash( id, nidn, nama, gelarDepan, gelarBelakang, pendidikanTerakhir);
}