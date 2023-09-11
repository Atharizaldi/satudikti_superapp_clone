import 'package:collection/collection.dart';

class GetDetailProdiReg {
  GetDetailProdiReg({
    required this.data,
    required this.message,
  });
  late final Data data;
  late final String message;

  GetDetailProdiReg.fromJson(Map<String, dynamic> json) {
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
    other is GetDetailProdiReg &&
        data == other.data &&
        message == other.message;

  @override
  int get hashCode => Object.hash( data, message);

}

class Data {
  Data({
    required this.prodi,
  });
  late final List<Prodi> prodi;

  Data.fromJson(Map<String, dynamic> json) {
    prodi = List.from(json['prodi']).map((e) => Prodi.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['prodi'] = prodi.map((e) => e.toJson()).toList();
    return _data;
  }

  @override
  bool operator ==(Object other) {
    return other is Data && IterableEquality().equals(prodi, other.prodi);
  }
  @override
  int get hashCode {
    return prodi.hashCode ;
  }

}

class Prodi {
  Prodi({
    required this.id,
    required this.kode,
    required this.nama,
    required this.status,
    required this.deskripsi,
    required this.visi,
    required this.misi,
    required this.kompetensi,
    required this.tglBerdiri,
    required this.skSelenggara,
    required this.tglSkSelenggara,
    required this.jalan,
    required this.kelurahan,
    required this.kodePos,
    required this.kabKota,
    required this.jenjangDidik,
    required this.pt,
    required this.telepon,
    required this.faksimile,
    required this.email,
    required this.website,
  });
  late final String id;
  late final String kode;
  late final String nama;
  late final String status;
  late final String deskripsi;
  late final String visi;
  late final String misi;
  late final String kompetensi;
  late final String tglBerdiri;
  late final String skSelenggara;
  late final String tglSkSelenggara;
  late final String jalan;
  late final String kelurahan;
  late final String kodePos;
  late final KabKota kabKota;
  late final JenjangDidik jenjangDidik;
  late final Pt pt;
  late final String telepon;
  late final String faksimile;
  late final String email;
  late final String website;

  Prodi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kode = json['kode'];
    nama = json['nama'];
    status = json['status'];
    deskripsi = json['deskripsi'];
    visi = json['visi'];
    misi = json['misi'];
    kompetensi = json['kompetensi'];
    tglBerdiri = json['tgl_berdiri'];
    skSelenggara = json['sk_selenggara'];
    tglSkSelenggara = json['tgl_sk_selenggara'];
    jalan = json['jalan'];
    kelurahan = json['kelurahan'];
    kodePos = json['kode_pos'];
    kabKota = KabKota.fromJson(json['kab_kota']);
    jenjangDidik = JenjangDidik.fromJson(json['jenjang_didik']);
    pt = Pt.fromJson(json['pt']);
    telepon = json['telepon'];
    faksimile = json['faksimile'];
    email = json['email'];
    website = json['website'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['kode'] = kode;
    _data['nama'] = nama;
    _data['status'] = status;
    _data['deskripsi'] = deskripsi;
    _data['visi'] = visi;
    _data['misi'] = misi;
    _data['kompetensi'] = kompetensi;
    _data['tgl_berdiri'] = tglBerdiri;
    _data['sk_selenggara'] = skSelenggara;
    _data['tgl_sk_selenggara'] = tglSkSelenggara;
    _data['jalan'] = jalan;
    _data['kelurahan'] = kelurahan;
    _data['kode_pos'] = kodePos;
    _data['kab_kota'] = kabKota.toJson();
    _data['jenjang_didik'] = jenjangDidik.toJson();
    _data['pt'] = pt.toJson();
    _data['telepon'] = telepon;
    _data['faksimile'] = faksimile;
    _data['email'] = email;
    _data['website'] = website;
    return _data;
  }

  @override
  bool operator ==(Object other) {
    return other is Prodi &&
        id == other.id &&
        kode == other.kode &&
        nama == other.nama &&
        status == other.status &&
        deskripsi == other.deskripsi &&
        visi == other.visi &&
        misi == other.misi &&
        kompetensi == other.kompetensi &&
        tglBerdiri == other.tglBerdiri &&
        skSelenggara == other.skSelenggara &&
        tglSkSelenggara == other.tglSkSelenggara &&
        jalan == other.jalan &&
        kelurahan == other.kelurahan &&
        kodePos == other.kodePos &&
        kabKota == other.kabKota &&
        jenjangDidik == other.jenjangDidik &&
        pt == other.pt &&
        telepon == other.telepon &&
        faksimile == other.faksimile &&
        email == other.email &&
        website == other.website;
  }
  @override
  int get hashCode {
    return id.hashCode ^
    kode.hashCode ^
    nama.hashCode ^
    status.hashCode ^
    deskripsi.hashCode ^
    visi.hashCode ^
    misi.hashCode ^
    kompetensi.hashCode ^
    tglBerdiri.hashCode ^
    skSelenggara.hashCode ^
    tglSkSelenggara.hashCode ^
    jalan.hashCode ^
    kelurahan.hashCode ^
    kodePos.hashCode ^
    kabKota.hashCode ^
    jenjangDidik.hashCode ^
    pt.hashCode ^
    telepon.hashCode ^
    faksimile.hashCode ^
    email.hashCode ^
    website.hashCode;
  }

}

class KabKota {
  KabKota({
    required this.id,
    required this.nama,
  });
  late final String id;
  late final String nama;

  KabKota.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['nama'] = nama;
    return _data;
  }

  @override
  bool operator ==(Object other) =>
     other is KabKota && id == other.id && nama == other.nama;

  @override
  int get hashCode => Object.hash( id, nama);
}

class JenjangDidik {
  JenjangDidik({
    required this.id,
    required this.nama,
  });
  late final int id;
  late final String nama;

  JenjangDidik.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['nama'] = nama;
    return _data;
  }

  @override
  bool operator ==(Object other) =>
    other is JenjangDidik && id == other.id && nama == other.nama;

  @override
  int get hashCode => Object.hash( id, nama);
}

class Pt {
  Pt({
    required this.id,
    required this.kode,
    required this.nama,
    required this.namaSingkat,
  });
  late final String id;
  late final String kode;
  late final String nama;
  late final String namaSingkat;

  Pt.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kode = json['kode'];
    nama = json['nama'];
    namaSingkat = json['nama_singkat'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['kode'] = kode;
    _data['nama'] = nama;
    _data['nama_singkat'] = namaSingkat;
    return _data;
  }

  @override
  bool operator ==(Object other) {
    return other is Pt &&
        id == other.id &&
        kode == other.kode &&
        nama == other.nama &&
        namaSingkat == other.namaSingkat;
  }
  @override
  int get hashCode {
    return id.hashCode ^
    kode.hashCode ^
    nama.hashCode ^
   namaSingkat.hashCode;
  }

}
