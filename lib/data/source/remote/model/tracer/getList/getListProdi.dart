class GetTracerListProdi {
  GetTracerListProdi({
    required this.data,
    required this.message,
  });

  late final List<DataProdiTracer> data;
  late final String message;

  GetTracerListProdi.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data'])
        .map((e) => DataProdiTracer.fromJson(e))
        .toList();
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
    return other is GetTracerListProdi &&
        data == other.data &&
        message == other.message;
  }
  @override
  int get hashCode {
    return data.hashCode ^ message.hashCode;
  }

}

class DataProdiTracer {
  DataProdiTracer({
    required this.idJenjangDidik,
    required this.idSms,
    required this.idSp,
    required this.kodeProdi,
    required this.kodePt,
    required this.namaProdi,
  });

  late final String idJenjangDidik;
  late final String idSms;
  late final String idSp;
  late final String kodeProdi;
  late final String kodePt;
  late final String namaProdi;

  DataProdiTracer.fromJson(Map<String, dynamic> json) {
    idJenjangDidik = json['id_jenjang_didik'];
    idSms = json['id_sms'];
    idSp = json['id_sp'];
    kodeProdi = json['kode_prodi'];
    kodePt = json['kode_pt'];
    namaProdi = json['nama_prodi'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id_jenjang_didik'] = idJenjangDidik;
    _data['id_sms'] = idSms;
    _data['id_sp'] = idSp;
    _data['kode_prodi'] = kodeProdi;
    _data['kode_pt'] = kodePt;
    _data['nama_prodi'] = namaProdi;
    return _data;
  }

  @override
  bool operator ==(Object other) {
    return other is DataProdiTracer &&
    idJenjangDidik  == other.idJenjangDidik &&
    idSms            == other.idSms &&
    idSp             == other.idSp &&
    kodeProdi        == other.kodeProdi &&
    kodePt           == other.kodePt &&
    namaProdi        == other.namaProdi;
  }
  @override
  int get hashCode {
    return idJenjangDidik.hashCode ^ idSms.hashCode ^ idSp.hashCode ^
    kodeProdi.hashCode ^
    kodePt.hashCode ^
    namaProdi.hashCode;
  }
  
}
