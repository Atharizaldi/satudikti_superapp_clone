
class GetTracerListProvinsi {
  GetTracerListProvinsi({
    required this.data,
    required this.message,
  });

  late final List<Provinsi> data;
  late final String message;

  GetTracerListProvinsi.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data']).map((e) => Provinsi.fromJson(e)).toList();
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e) => e.toJson()).toList();
    _data['message'] = message;
    return _data;
  }

  @override
  bool operator ==(Object other) {
    return other is GetTracerListProvinsi &&
        data == other.data &&
        message == other.message;
  }
  @override
  int get hashCode {
    return data.hashCode ^ message.hashCode;
  }


}

class Provinsi {
  Provinsi({
    required this.kodeProvinsi,
    required this.namaProvinsi,
  });

  late final String kodeProvinsi;
  late final String namaProvinsi;

  Provinsi.fromJson(Map<String, dynamic> json) {
    kodeProvinsi = json['kode_provinsi'];
    namaProvinsi = json['provinsi'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['kode_provinsi'] = kodeProvinsi;
    _data['provinsi'] = namaProvinsi;
    return _data;
  }

  @override
  bool operator ==(Object other) {
    return other is Provinsi &&
    kodeProvinsi == other.kodeProvinsi &&
    namaProvinsi == other.namaProvinsi;
  }
  @override
  int get hashCode {
    return kodeProvinsi.hashCode ^ namaProvinsi.hashCode;
  }


}
