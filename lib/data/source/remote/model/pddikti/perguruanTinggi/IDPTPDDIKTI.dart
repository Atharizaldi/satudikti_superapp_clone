class IDPTPDDIKTI {
  late final String message;
  late final IDPTPDDIKTIData data;

  IDPTPDDIKTI({required this.message, required this.data});

  IDPTPDDIKTI.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = IDPTPDDIKTIData.fromJson(json['data']);
  }
}

class IDPTPDDIKTIData {
  late final List<PerguruanTinggiData> perguruanTinggi;

  IDPTPDDIKTIData({required this.perguruanTinggi});

  IDPTPDDIKTIData.fromJson(Map<String, dynamic> json) {
    perguruanTinggi = List.from(json['perguruan_tinggi'])
        .map((e) => PerguruanTinggiData.fromJson(e))
        .toList();
  }
}

class PerguruanTinggiData {
  late final String id;
  late final String kode;
  late final String nama;
  late final String namaSingkat;
  late final String status;
  late final String akreditasi;
  late final String urlLogo;

  PerguruanTinggiData(
      {required this.id,
      required this.kode,
      required this.nama,
      required this.namaSingkat,
      required this.status,
      required this.akreditasi,
      required this.urlLogo});

  PerguruanTinggiData.fromJson(Map<String, dynamic> json) {
    id = json['id'] != null ? json['id'] : '-';
    kode = json['kode'] != null ? json['kode'] : '-';
    nama = json['nama'] != null ? json['nama'] : '-';
    namaSingkat = json['nama_singkat'] != null ? json['nama_singkat'] : '-';
    status = json['status'] != null ? json['status'] : '-';
    akreditasi = json['akreditasi'] != null ? json['akreditasi'] : '-';
    urlLogo = json['url_logo'] != null ? json['url_logo'] : '-';
  }
}
