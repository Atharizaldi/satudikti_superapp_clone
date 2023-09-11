class GetDetailMahasiswaReg {
  GetDetailMahasiswaReg({
    required this.data,
    required this.message,
  });
  late final Data data;
  late final String message;

  GetDetailMahasiswaReg.fromJson(Map<String, dynamic> json) {
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
    other is GetDetailMahasiswaReg &&
    data == other.data &&
    message == other.message;

  @override
  int get hashCode => Object.hash( data, message);
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

  @override
  bool operator ==(Object other) {
    return other is Data &&
    mahasiswa == other.mahasiswa;
  }
  @override
  int get hashCode {
    return mahasiswa.hashCode;
  }
}

class Mahasiswa {
  Mahasiswa({
    required this.nama,
    required this.jenisKelamin,
    required this.terdaftar,
  });
  late final String nama;
  late final String jenisKelamin;
  late final Terdaftar terdaftar;

  Mahasiswa.fromJson(Map<String, dynamic> json) {
    nama = json['nama'];
    jenisKelamin = json['jenis_kelamin'];
    terdaftar = Terdaftar.fromJson(json['terdaftar']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['nama'] = nama;
    _data['jenis_kelamin'] = jenisKelamin;
    _data['terdaftar'] = terdaftar.toJson();
    return _data;
  }

  @override
  bool operator ==(Object other) =>
     other is Mahasiswa &&
    nama == other.nama &&
    jenisKelamin == other.jenisKelamin &&
    terdaftar == other.terdaftar;

  @override
  int get hashCode => Object.hash(nama, jenisKelamin, terdaftar);
}

class Terdaftar {
  Terdaftar({
    required this.nim,
    required this.kodePt,
    required this.namaPt,
    required this.kodeProdi,
    required this.namaProdi,
    required this.jenjangDidik,
    required this.smtMulai,
    required this.jenisDaftar,
    required this.jenisKeluar,
  });
  late final String nim;
  late final String kodePt;
  late final String namaPt;
  late final String kodeProdi;
  late final String namaProdi;
  late final JenjangDidik jenjangDidik;
  late final String smtMulai;
  late final JenisDaftar jenisDaftar;
  late final JenisKeluar jenisKeluar;

  Terdaftar.fromJson(Map<String, dynamic> json) {
    nim = json['nim'];
    kodePt = json['kode_pt'];
    namaPt = json['nama_pt'];
    kodeProdi = json['kode_prodi'];
    namaProdi = json['nama_prodi'];
    jenjangDidik = JenjangDidik.fromJson(json['jenjang_didik']);
    smtMulai = json['smt_mulai'];
    jenisDaftar = JenisDaftar.fromJson(json['jenis_daftar']);
    jenisKeluar = JenisKeluar.fromJson(json['jenis_keluar']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['nim'] = nim;
    _data['kode_pt'] = kodePt;
    _data['nama_pt'] = namaPt;
    _data['kode_prodi'] = kodeProdi;
    _data['nama_prodi'] = namaProdi;
    _data['jenjang_didik'] = jenjangDidik.toJson();
    _data['smt_mulai'] = smtMulai;
    _data['jenis_daftar'] = jenisDaftar.toJson();
    _data['jenis_keluar'] = jenisKeluar.toJson();
    return _data;
  }

  @override
  bool operator ==(Object other) =>
     other is Terdaftar &&
    nim == other.nim &&
    kodePt == other.kodePt &&
    namaPt == other.namaPt &&
    kodeProdi == other.kodeProdi &&
    namaProdi == other.namaProdi &&
    jenjangDidik == other.jenjangDidik &&
    smtMulai == other.smtMulai &&
    jenisDaftar == other.jenisDaftar &&
    jenisKeluar == other.jenisKeluar;

  @override
  int get hashCode => Object.hash( nim, kodePt, namaPt,kodeProdi, namaProdi, jenjangDidik,smtMulai,jenisDaftar, jenisKeluar);
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

  @override
  bool operator ==(Object other) {
    return other is JenjangDidik &&
    nama == other.nama;
  }
  @override
  int get hashCode {
    return nama.hashCode;
  }
}

class JenisDaftar {
  JenisDaftar({
    required this.nama,
  });
  late final String nama;

  JenisDaftar.fromJson(Map<String, dynamic> json) {
    nama = json['nama'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['nama'] = nama;
    return _data;
  }

  @override
  bool operator ==(Object other) {
    return other is JenisDaftar &&
    nama == other.nama;
  }
  @override
  int get hashCode {
    return nama.hashCode;
  }
}

class JenisKeluar {
  JenisKeluar({
    required this.ket,
  });
  late final String ket;

  JenisKeluar.fromJson(Map<String, dynamic> json) {
    if (json['ket'] == null) {
      ket = '-';
    } else {
      ket = json['ket'];
    }
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ket'] = ket;
    return _data;
  }

  @override
  bool operator ==(Object other) {
    return other is JenisKeluar &&
    ket == other.ket;
  }
  @override
  int get hashCode {
    return ket.hashCode;
  }
}
