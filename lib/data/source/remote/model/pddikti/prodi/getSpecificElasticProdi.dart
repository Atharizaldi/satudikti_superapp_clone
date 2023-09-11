import 'package:collection/collection.dart';

class GetSpecificElasticProdi {
  GetSpecificElasticProdi({
    required this.data,
    required this.message,
  });
  late final Data data;
  late final String message;
  
  GetSpecificElasticProdi.fromJson(Map<String, dynamic> json){
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
     other is GetSpecificElasticProdi &&
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
  
  Data.fromJson(Map<String, dynamic> json){
    prodi = List.from(json['prodi']).map((e)=>Prodi.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['prodi'] = prodi.map((e)=>e.toJson()).toList();
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
    required this.nama,
    required this.lembaga,
    required this.akreditas,
    required this.jenjang,
    required this.kodePt,
    required this.kodeProdi,
  });
  late final String id;
  late final String nama;
  late final String lembaga;
  late final String akreditas;
  late final String jenjang;
  late final String kodePt;
  late final String kodeProdi;
  
  Prodi.fromJson(Map<String, dynamic> json){
    id = json['id'];
    nama = json['nama'];
    lembaga = json['lembaga'];
    akreditas = json['akreditas'];
    jenjang = json['jenjang'];
    kodePt = json['kode_pt'];
    kodeProdi = json['kode_prodi'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['nama'] = nama;
    _data['lembaga'] = lembaga;
    _data['akreditas'] = akreditas;
    _data['jenjang'] = jenjang;
    _data['kode_pt'] = kodePt;
    _data['kode_prodi'] = kodeProdi;
    return _data;
  }

  @override
  bool operator ==(Object other) =>
     other is Prodi &&
    id == other.id &&
    nama == other.nama &&
    lembaga == other.lembaga &&
    akreditas == other.akreditas &&
    jenjang == other.jenjang &&
    kodePt == other.kodePt &&
    kodeProdi == other.kodeProdi;

  @override
  int get hashCode => Object.hash( id, nama, lembaga, akreditas, jenjang, kodePt, kodeProdi);
}