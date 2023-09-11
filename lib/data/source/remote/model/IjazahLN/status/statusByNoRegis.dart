class StatusByNoReg {
  StatusByNoReg({
    required this.data,
    required this.message,
  });
  late final Data data;
  late final String message;

  StatusByNoReg.fromJson(Map<String, dynamic> json) {
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
    required this.progress,
  });
  late final Progress progress;

  Data.fromJson(Map<String, dynamic> json) {
    progress = Progress.fromJson(json['progress']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['progress'] = progress.toJson();
    return _data;
  }
}

class Progress {
  Progress({
    required this.nama,
    required this.noRegistrasi,
    required this.perguruanTinggi,
    required this.programStudi,
    required this.gelar,
    required this.tanggalPendaftaran,
    required this.statusSaatIni,
    required this.progresPenyetaraan,
  });
  late final String nama;
  late final String noRegistrasi;
  late final String perguruanTinggi;
  late final String programStudi;
  late final String gelar;
  late final String tanggalPendaftaran;
  late final String statusSaatIni;
  late final List<ProgresPenyetaraan> progresPenyetaraan;

  Progress.fromJson(Map<String, dynamic> json) {
    nama = json['nama'];
    noRegistrasi = json['no_registrasi'];
    perguruanTinggi = json['perguruan_tinggi'];
    programStudi = json['program_studi'];
    gelar = json['gelar'];
    tanggalPendaftaran = json['tanggal_pendaftaran'];
    statusSaatIni = json['status_saat_ini'];
    progresPenyetaraan = List.from(json['progres_penyetaraan'])
        .map((e) => ProgresPenyetaraan.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['nama'] = nama;
    _data['no_registrasi'] = noRegistrasi;
    _data['perguruan_tinggi'] = perguruanTinggi;
    _data['program_studi'] = programStudi;
    _data['gelar'] = gelar;
    _data['tanggal_pendaftaran'] = tanggalPendaftaran;
    _data['status_saat_ini'] = statusSaatIni;
    _data['progres_penyetaraan'] =
        progresPenyetaraan.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ProgresPenyetaraan {
  ProgresPenyetaraan({
    required this.status,
    required this.aktifitas,
    required this.tanggal,
    required this.jam,
  });
  late final String status;
  late final String aktifitas;
  late final String tanggal;
  late final String jam;

  ProgresPenyetaraan.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    aktifitas = json['aktifitas'];
    tanggal = json['tanggal'];
    jam = json['jam'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['aktifitas'] = aktifitas;
    _data['tanggal'] = tanggal;
    _data['jam'] = jam;
    return _data;
  }
}
