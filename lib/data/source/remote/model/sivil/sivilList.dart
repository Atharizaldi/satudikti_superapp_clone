class Sivil {
  Sivil({
    required this.data,
    required this.message,
  });
  late final Data data;
  late final String message;

  Sivil.fromJson(Map<String, dynamic> json) {
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
    required this.mahasiswa,
  });
  late final List<Mahasiswa> mahasiswa;

  Data.fromJson(Map<String, dynamic> json) {
    mahasiswa =
        List.from(json['mahasiswa']).map((e) => Mahasiswa.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['mahasiswa'] = mahasiswa.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Mahasiswa {
  Mahasiswa({
    required this.nama,
    required this.terdaftar,
  });
  late final String nama;
  late final Terdaftar terdaftar;

  Mahasiswa.fromJson(Map<String, dynamic> json) {
    nama = json['nama'];
    terdaftar = Terdaftar.fromJson(json['terdaftar']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['nama'] = nama;
    _data['terdaftar'] = terdaftar.toJson();
    return _data;
  }
}

class Terdaftar {
  Terdaftar({
    required this.kodePt,
    required this.namaPt,
    required this.kodeProdi,
    required this.namaProdi,
    required this.jenjangDidik,
    required this.nim,
    required this.tglKeluar,
    required this.noIjazah,
  });
  late final String kodePt;
  late final String namaPt;
  late final String kodeProdi;
  late final String namaProdi;
  late final JenjangDidik jenjangDidik;
  late final String nim;
  late final String tglKeluar;
  late final String noIjazah;

  Terdaftar.fromJson(Map<String, dynamic> json) {
    kodePt = json['kode_pt'];
    namaPt = json['nama_pt'];
    kodeProdi = json['kode_prodi'];
    namaProdi = json['nama_prodi'];
    jenjangDidik = JenjangDidik.fromJson(json['jenjang_didik']);
    nim = json['nim'];
    tglKeluar = json['tgl_keluar'];
    noIjazah = json['no_ijazah'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['kode_pt'] = kodePt;
    _data['nama_pt'] = namaPt;
    _data['kode_prodi'] = kodeProdi;
    _data['nama_prodi'] = namaProdi;
    _data['jenjang_didik'] = jenjangDidik.toJson();
    _data['nim'] = nim;
    _data['tgl_keluar'] = tglKeluar;
    _data['no_ijazah'] = noIjazah;
    return _data;
  }
}

class JenjangDidik {
  JenjangDidik({
    required this.nama,
  });
  late final String nama;

  JenjangDidik.fromJson(Map<String, dynamic> json) {
    nama = json['nama'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['nama'] = nama;
    return _data;
  }
}
