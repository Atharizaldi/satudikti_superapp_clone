import 'package:collection/collection.dart';

class GetDetailDosen  {
  GetDetailDosen({
    required this.data,
    required this.message,
  });
  late final Data data;
  late final String message;
  
  GetDetailDosen.fromJson(Map<String, dynamic> json){
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
    other is GetDetailDosen &&
    data == other.data &&
    message == other.message;

  @override
  int get hashCode => Object.hash(
      data, message);

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
    required this.nidn,
    required this.nmProdi,
    required this.kodeProdi,
    required this.nmPt,
    required this.kodePt,
    required this.pendidikanTerakhir,
    required this.jenisKelamin,
    required this.ikatanKerja,
    required this.statusKeaktifan,
    required this.jabatanFungsional,
  });
  late final String id;
  late final String nama;
  late final String nidn;
  late final String nmProdi;
  late final String kodeProdi;
  late final String nmPt;
  late final String kodePt;
  late final String pendidikanTerakhir;
  late final String jenisKelamin;
  late final IkatanKerja ikatanKerja;
  late final StatusKeaktifan statusKeaktifan;
  late final JabatanFungsional jabatanFungsional;
  
  Dosen.fromJson(Map<String, dynamic> json){
    id = json['id'];
    nama = json['nama'];
    nidn = json['nidn'];
    nmProdi = json['nm_prodi'];
    kodeProdi = json['kode_prodi'];
    nmPt = json['nm_pt'];
    kodePt = json['kode_pt'];
    pendidikanTerakhir = json['pendidikan_terakhir'];
    jenisKelamin = json['jenis_kelamin'];
    ikatanKerja = IkatanKerja.fromJson(json['ikatan_kerja']);
    statusKeaktifan = StatusKeaktifan.fromJson(json['status_keaktifan']);
    jabatanFungsional = JabatanFungsional.fromJson(json['jabatan_fungsional']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['nama'] = nama;
    _data['nidn'] = nidn;
    _data['nm_prodi'] = nmProdi;
    _data['kode_prodi'] = kodeProdi;
    _data['nm_pt'] = nmPt;
    _data['kode_pt'] = kodePt;
    _data['pendidikan_terakhir'] = pendidikanTerakhir;
    _data['jenis_kelamin'] = jenisKelamin;
    _data['ikatan_kerja'] = ikatanKerja.toJson();
    _data['status_keaktifan'] = statusKeaktifan.toJson();
    _data['jabatan_fungsional'] = jabatanFungsional.toJson();
    return _data;
  }

  @override
  bool operator ==(Object other) =>
      other is Dosen &&
    id == other.id &&
    nama == other.nama &&
    nidn == other.nidn &&
    nmProdi == other.nmProdi &&
    kodeProdi == other.kodeProdi &&
    nmPt == other.nmPt &&
    kodePt == other.kodePt &&
    pendidikanTerakhir == other.pendidikanTerakhir &&
    jenisKelamin == other.jenisKelamin &&
    ikatanKerja == other.ikatanKerja &&
    statusKeaktifan == other.statusKeaktifan &&
    jabatanFungsional == other.jabatanFungsional;

  @override
  int get hashCode => Object.hash(
      id, nama, nidn, nmProdi, kodeProdi, nmPt, kodePt, pendidikanTerakhir,
  jenisKelamin, ikatanKerja, statusKeaktifan, jabatanFungsional);

}

class IkatanKerja {
  IkatanKerja({
    required this.id,
    required this.nama,
  });
  late final String id;
  late final String nama;
  
  IkatanKerja.fromJson(Map<String, dynamic> json){
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
    other is IkatanKerja &&
    id == other.id &&
    nama == other.nama;

  @override
  int get hashCode => Object.hash(
      id, nama);

}

class StatusKeaktifan {
  StatusKeaktifan({
    required this.id,
    required this.nama,
  });
  late final int id;
  late final String nama;
  
  StatusKeaktifan.fromJson(Map<String, dynamic> json){
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
     other is StatusKeaktifan &&
    id == other.id &&
    nama == other.nama;

  @override
  int get hashCode => Object.hash( id, nama);

}

class JabatanFungsional {
  JabatanFungsional({
    required this.id,
    required this.nama,
  });
  late final int id;
  late final String nama;
  
  JabatanFungsional.fromJson(Map<String, dynamic> json){
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
    other is JabatanFungsional &&
    id == other.id &&
    nama == other.nama;

    @override
    int get hashCode => Object.hash( id, nama);

}