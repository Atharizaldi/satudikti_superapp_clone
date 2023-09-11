class GetTracerListKabupaten {
  GetTracerListKabupaten({
    required this.data,
    required this.message,
  });

  late final List<Kabupaten> data;
  late final String message;

  GetTracerListKabupaten.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data']).map((e) => Kabupaten.fromJson(e)).toList();
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e) => e.toJson()).toList();
    _data['message'] = message;
    return _data;
  }

  @override
  bool operator ==(Object other) =>
     other is GetTracerListKabupaten &&
    data == other.data &&
    message == other.message;

  @override
  int get hashCode => Object.hash( data, message);

}

class Kabupaten {
  Kabupaten({
    required this.kodeProvinsi,
    required this.kodeKabKota,
    required this.kabKota,
  });

  late final String kodeProvinsi;
  late final String kodeKabKota;
  late final String kabKota;

  Kabupaten.fromJson(Map<String, dynamic> json) {
    kodeProvinsi = json['kode_provinsi'];
    kodeKabKota = json['kode_kab_kota'];
    kabKota = json['kab_kota'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['kode_provinsi'] = kodeProvinsi;
    _data['kode_kab_kota'] = kodeKabKota;
    _data['kab_kota'] = kabKota;
    return _data;
  }

  @override
  bool operator ==(Object other) {
    return other is Kabupaten &&
    kodeProvinsi == other.kodeProvinsi &&
    kodeKabKota == other.kodeKabKota &&
    kabKota == other.kabKota;
  }
  @override
  int get hashCode {
    return kodeProvinsi.hashCode ^ kodeKabKota.hashCode ^ kabKota.hashCode;
  }
  
}
