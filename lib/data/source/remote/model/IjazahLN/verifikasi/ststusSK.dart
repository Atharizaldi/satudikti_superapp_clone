class VerifikasiSK {
  VerifikasiSK({
    required this.message,
    required this.data,
  });
  late final String message;
  late final Data data;

  VerifikasiSK.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.statusSk,
  });
  late final StatusSk statusSk;

  Data.fromJson(Map<String, dynamic> json) {
    statusSk = StatusSk.fromJson(json['status_sk']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status_sk'] = statusSk.toJson();
    return _data;
  }
}

class StatusSk {
  StatusSk({
    required this.namaPengusul,
    required this.namaPt,
    required this.namaProdi,
    required this.namaGelar,
    required this.hasilKesetaraan,
    required this.noSk,
    required this.tglSk,
  });
  late final String namaPengusul;
  late final String namaPt;
  late final String namaProdi;
  late final String namaGelar;
  late final String hasilKesetaraan;
  late final String noSk;
  late final String tglSk;

  StatusSk.fromJson(Map<String, dynamic> json) {
    namaPengusul = json['nama_pengusul'];
    namaPt = json['nama_pt'];
    namaProdi = json['nama_prodi'];
    namaGelar = json['nama_gelar'];
    hasilKesetaraan = json['hasil_kesetaraan'];
    noSk = json['no_sk'];
    tglSk = json['tgl_sk'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['nama_pengusul'] = namaPengusul;
    _data['nama_pt'] = namaPt;
    _data['nama_prodi'] = namaProdi;
    _data['nama_gelar'] = namaGelar;
    _data['hasil_kesetaraan'] = hasilKesetaraan;
    _data['no_sk'] = noSk;
    _data['tgl_sk'] = tglSk;
    return _data;
  }
}
