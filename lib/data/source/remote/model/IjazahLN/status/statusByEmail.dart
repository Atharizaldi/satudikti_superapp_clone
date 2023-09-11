class StatusByEmail {
  StatusByEmail({
    required this.data,
    required this.message,
  });
  late final Data data;
  late final String message;

  StatusByEmail.fromJson(Map<String, dynamic> json) {
    data = Data.fromJson(json['data']);
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.toJson();
    _data['message'] = message;
    return _data;
  }
}

class Data {
  Data({
    required this.daftarUsulan,
  });
  late final List<DaftarUsulan> daftarUsulan;

  Data.fromJson(Map<String, dynamic> json) {
    daftarUsulan = List.from(json['daftar_usulan'])
        .map((e) => DaftarUsulan.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['daftar_usulan'] = daftarUsulan.map((e) => e.toJson()).toList();
    return _data;
  }
}

class DaftarUsulan {
  DaftarUsulan({
    required this.noRegistrasi,
    required this.namaPt,
    required this.namaProdi,
    required this.namaGelar,
    required this.namaJenjangStudi,
    required this.singkatJenjangStudi,
  });
  late final int noRegistrasi;
  late final String namaPt;
  late final String namaProdi;
  late final String namaGelar;
  late final String namaJenjangStudi;
  late final String singkatJenjangStudi;

  DaftarUsulan.fromJson(Map<String, dynamic> json) {
    noRegistrasi = json['no_registrasi'];
    namaPt = json['nama_pt'];
    namaProdi = json['nama_prodi'];
    namaGelar = json['nama_gelar'];
    namaJenjangStudi = json['nama_jenjang_studi'];
    singkatJenjangStudi = json['singkat_jenjang_studi'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['no_registrasi'] = noRegistrasi;
    _data['nama_pt'] = namaPt;
    _data['nama_prodi'] = namaProdi;
    _data['nama_gelar'] = namaGelar;
    _data['nama_jenjang_studi'] = namaJenjangStudi;
    _data['singkat_jenjang_studi'] = singkatJenjangStudi;
    return _data;
  }
}
