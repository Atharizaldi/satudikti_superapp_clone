class GetPelaporanPT {
  GetPelaporanPT({
    required this.data,
    required this.message,
  });
  late final Data data;
  late final String message;

  GetPelaporanPT.fromJson(Map<String, dynamic> json) {
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
     other is GetPelaporanPT &&
        data == other.data &&
        message == other.message;

  @override
  int get hashCode => Object.hash( data, message);

}

class Data {
  Data({
    required this.pelaporan,
  });
  late final Pelaporan pelaporan;

  Data.fromJson(Map<String, dynamic> json) {
    pelaporan = Pelaporan.fromJson(json['pelaporan']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['pelaporan'] = pelaporan.toJson();
    return _data;
  }

  @override
  bool operator ==(Object other) {
    return other is Data && pelaporan == other.pelaporan;
  }
  @override
  int get hashCode {
    return pelaporan.hashCode;
  }
}

class Pelaporan {
  Pelaporan({
    required this.kodePt,
    required this.jln,
    required this.namaPt,
    required this.provinsiPt,
    required this.kabKotaPt,
    required this.kecamatanPt,
    required this.tglBerdiriPt,
  });
  late final String kodePt;
  late final String jln;
  late final String namaPt;
  late final String provinsiPt;
  late final String kabKotaPt;
  late final String kecamatanPt;
  late final String tglBerdiriPt;

  Pelaporan.fromJson(Map<String, dynamic> json) {
    kodePt = json['kode_pt'];
    jln = json['jln'];
    namaPt = json['nama_pt'];
    provinsiPt = json['provinsi_pt'];
    kabKotaPt = json['kab_kota_pt'];
    kecamatanPt = json['kecamatan_pt'];
    tglBerdiriPt = json['tgl_berdiri_pt'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['kode_pt'] = kodePt;
    _data['jln'] = jln;
    _data['nama_pt'] = namaPt;
    _data['provinsi_pt'] = provinsiPt;
    _data['kab_kota_pt'] = kabKotaPt;
    _data['kecamatan_pt'] = kecamatanPt;
    _data['tgl_berdiri_pt'] = tglBerdiriPt;
    return _data;
  }

  @override
  bool operator ==(Object other) =>
    other is Pelaporan &&
        kodePt == other.kodePt &&
        jln == other.jln &&
        namaPt == other.namaPt &&
        provinsiPt == other.provinsiPt &&
        kabKotaPt == other.kabKotaPt &&
        kecamatanPt == other.kecamatanPt &&
        tglBerdiriPt == other.tglBerdiriPt;

  @override
  int get hashCode => Object.hash( kodePt, jln, namaPt, provinsiPt, kabKotaPt, kecamatanPt, tglBerdiriPt);

}