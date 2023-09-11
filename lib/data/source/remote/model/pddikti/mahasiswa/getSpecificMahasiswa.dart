import 'package:collection/collection.dart';

class GetSpecificMahasiswa {
  GetSpecificMahasiswa({
    required this.data,
    required this.message,
  });
  late final Data data;
  late final String message;
  
  GetSpecificMahasiswa.fromJson(Map<String, dynamic> json){
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
  bool operator ==(Object other) {
    return other is GetSpecificMahasiswa &&
    data == other.data &&
    message == other.message;
  }
  @override
  int get hashCode {
    return data.hashCode ^ message.hashCode;
  }
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
    required this.nmPd,
    required this.nipd,
    required this.namaProdi,
    required this.namaPt,
    required this.npsn,
    required this.kodeProdi,
  });
  late final String nmPd;
  late final String nipd;
  late final String namaProdi;
  late final String namaPt;
  late final String npsn;
  late final String kodeProdi;
  
  Mahasiswa.fromJson(Map<String, dynamic> json){
    nmPd = json['nm_pd'];
    nipd = json['nipd'];
    namaProdi = json['nama_prodi'];
    namaPt = json['nama_pt'];
    npsn = json['npsn'];
    kodeProdi = json['kode_prodi'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['nm_pd'] = nmPd;
    _data['nipd'] = nipd;
    _data['nama_prodi'] = namaProdi;
    _data['nama_pt'] = namaPt;
    _data['npsn'] = npsn;
    _data['kode_prodi'] = kodeProdi;
    return _data;
  }

  @override
  bool operator ==(Object other) {
    return other is Mahasiswa &&
    nmPd == other.nmPd &&
    nipd == other.nipd &&
    namaProdi == other.namaProdi &&
    namaPt == other.namaPt &&
    npsn == other.npsn &&
    kodeProdi == other.kodeProdi;
  }

  @override
  int get hashCode {
    return nmPd.hashCode ^
    nipd.hashCode ^
    namaProdi.hashCode ^
    namaPt.hashCode ^
    npsn.hashCode ^
    kodeProdi.hashCode;
  }

}