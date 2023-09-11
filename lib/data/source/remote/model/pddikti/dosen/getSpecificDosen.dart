import 'package:collection/collection.dart';

class GetSpecificDosen {
  GetSpecificDosen({
    required this.data,
    required this.message,
  });
  late final Data data;
  late final String message;
  
  GetSpecificDosen.fromJson(Map<String, dynamic> json){
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
  bool operator ==(Object other)  =>
      other is GetSpecificDosen &&
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
  
  Data.fromJson(Map<String, dynamic> json){
    dosen = List.from(json['dosen']).map((e)=>Dosen.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['dosen'] = dosen.map((e)=>e.toJson()).toList();
    return _data;
  }

  @override
  bool operator ==(Object other) {
    return other is Data &&
    IterableEquality().equals(dosen, other.dosen);
  }
  @override
  int get hashCode {
    return const IterableEquality().hash(dosen);
  }
}

class Dosen {
  Dosen({
    required this.id,
    required this.nama,
    required this.nmProdi,
    required this.kodeProdi,
    required this.nmPt,
    required this.kodePt,
  });
  late final String id;
  late final String nama;
  late final String nmProdi;
  late final String kodeProdi;
  late final String nmPt;
  late final String kodePt;
  
  Dosen.fromJson(Map<String, dynamic> json){
    id = json['id'];
    nama = json['nama'];
    nmProdi = json['nm_prodi'];
    kodeProdi = json['kode_prodi'];
    nmPt = json['nm_pt'];
    kodePt = json['kode_pt'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['nama'] = nama;
    _data['nm_prodi'] = nmProdi;
    _data['kode_prodi'] = kodeProdi;
    _data['nm_pt'] = nmPt;
    _data['kode_pt'] = kodePt;
    return _data;
  }

  @override
  bool operator ==(Object other) =>
     other is Dosen &&
    id == other.id &&
    nama == other.nama &&
    nmProdi == other.nmProdi &&
    kodeProdi == other.kodeProdi &&
    nmPt == other.nmPt &&
    kodePt == other.kodePt;

  @override
  int get hashCode => Object.hash( id, nama, nmProdi, nmPt, kodeProdi, kodePt);
}