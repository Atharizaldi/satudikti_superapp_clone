import 'package:collection/collection.dart';

class GetListPT {
  GetListPT({
    required this.data,
    required this.message,
  });
  late final Data data;
  late final String message;
  
  GetListPT.fromJson(Map<String, dynamic> json){
    try {
      data = Data.fromJson(json['data']);
    } catch (e) {
      data = Data.forNull();
    }
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
     other is GetListPT &&
    data == other.data &&
    message == other.message;

  @override
  int get hashCode => Object.hash( data, message);

}

class Data {
  Data({
    required this.perguruanTinggi,
  });
  late final List<PerguruanTinggi> perguruanTinggi;
  
  Data.fromJson(Map<String, dynamic> json){
    perguruanTinggi = List.from(json['perguruan_tinggi']).map((e)=>PerguruanTinggi.fromJson(e)).toList();
  }

  Data.forNull(){
    perguruanTinggi = [];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['perguruan_tinggi'] = perguruanTinggi.map((e)=>e.toJson()).toList();
    return _data;
  }

  @override
  bool operator ==(Object other) {
    return other is Data &&
    IterableEquality().equals(perguruanTinggi, other.perguruanTinggi);
  }
  @override
  int get hashCode {
    return const IterableEquality().hash(perguruanTinggi);
  }


}

class PerguruanTinggi {
  PerguruanTinggi({
    required this.id,
    required this.kode,
    required this.nama,
    required this.namaSingkat,
    required this.status,
    required this.akreditasi,
    required this.urlLogo,
  });
  late final String id;
  late final String kode;
  late final String nama;
  late final String namaSingkat;
  late final String status;
  late final String akreditasi;
  late final String urlLogo;
  
  PerguruanTinggi.fromJson(Map<String, dynamic> json){
    id = json['id'];
    kode = json['kode'];
    nama = json['nama'];
    namaSingkat = json['nama_singkat'];
    status = json['status'];
    akreditasi = json['akreditasi'];
    urlLogo = json['url_logo'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['kode'] = kode;
    _data['nama'] = nama;
    _data['nama_singkat'] = namaSingkat;
    _data['status'] = status;
    _data['akreditasi'] = akreditasi;
    _data['url_logo'] = urlLogo;
    return _data;
  }

  @override
  bool operator ==(Object other) =>
     other is PerguruanTinggi &&
    id == other.id &&
    kode == other.kode &&
    nama == other.nama &&
    namaSingkat == other.namaSingkat &&
    status == other.status &&
    akreditasi == other.akreditasi &&
    urlLogo == other.urlLogo;

  @override
  int get hashCode => Object.hash( id, kode, nama, namaSingkat, status, akreditasi, urlLogo);

  
}