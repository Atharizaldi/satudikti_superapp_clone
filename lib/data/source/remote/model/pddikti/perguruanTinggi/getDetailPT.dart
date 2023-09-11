class GetDetailPT {
  GetDetailPT({
    required this.data,
    required this.message,
  });
  late final Data data;
  late final String message;
  
  GetDetailPT.fromJson(Map<String, dynamic> json){
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
  bool operator ==(Object other) {
    return other is GetDetailPT &&
    data == other.data &&
    message == other.message;
  }
  @override
  int get hashCode {
    return data.hashCode ^ message.hashCode;
  }
}

class Data {
  Data({
    required this.perguruanTinggi,
  });
  late final PerguruanTinggi perguruanTinggi;
  
  Data.fromJson(Map<String, dynamic> json){
    perguruanTinggi = PerguruanTinggi.fromJson(json['perguruan_tinggi']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['perguruan_tinggi'] = perguruanTinggi.toJson();
    return _data;
  }

  @override
  bool operator ==(Object other) {
    return other is Data &&
    perguruanTinggi == other.perguruanTinggi;
  }
  @override
  int get hashCode {
    return perguruanTinggi.hashCode;
  }
}

class PerguruanTinggi {
  PerguruanTinggi({
    required this.id,
    required this.kode,
    required this.nama,
    required this.namaSingkat,
    required this.urlLogo,
    required this.status,
    required this.skPendirian,
    required this.tglSkPendirian,
    required this.alamat,
    required this.propinsi,
    required this.telepon,
    required this.faksimile,
    required this.website,
    required this.email,
    required this.pimpinan,
  });
  late final String id;
  late final String kode;
  late final String nama;
  late final String namaSingkat;
  late final String urlLogo;
  late final String status;
  late final String skPendirian;
  late final String tglSkPendirian;
  late final Alamat alamat;
  late final Propinsi propinsi;
  late final String telepon;
  late final String faksimile;
  late final String website;
  late final String email;
  late final Pimpinan pimpinan;
  
  PerguruanTinggi.fromJson(Map<String, dynamic> json){
    id = json['id'];
    kode = json['kode'];
    nama = json['nama'];
    namaSingkat = json['nama_singkat'];
    urlLogo = json['url_logo'];
    status = json['status'];
    skPendirian = json['sk_pendirian'];
    tglSkPendirian = json['tgl_sk_pendirian'];
    alamat = Alamat.fromJson(json['alamat']);
    propinsi = Propinsi.fromJson(json['propinsi']);
    telepon = json['telepon'];
    faksimile = json['faksimile'];
    website = json['website'];
    email = json['email'];
    pimpinan = Pimpinan.fromJson(json['pimpinan']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['kode'] = kode;
    _data['nama'] = nama;
    _data['nama_singkat'] = namaSingkat;
    _data['url_logo'] = urlLogo;
    _data['status'] = status;
    _data['sk_pendirian'] = skPendirian;
    _data['tgl_sk_pendirian'] = tglSkPendirian;
    _data['alamat'] = alamat.toJson();
    _data['propinsi'] = propinsi.toJson();
    _data['telepon'] = telepon;
    _data['faksimile'] = faksimile;
    _data['website'] = website;
    _data['email'] = email;
    _data['pimpinan'] = pimpinan.toJson();
    return _data;
  }

  @override
  bool operator ==(Object other) {
    return other is PerguruanTinggi &&
    id == other.id &&
    kode == other.kode &&
    nama == other.nama &&
    namaSingkat == other.namaSingkat &&
    urlLogo == other.urlLogo &&
    status == other.status &&
    skPendirian == other.skPendirian &&
    tglSkPendirian == other.tglSkPendirian &&
    alamat == other.alamat &&
    propinsi == other.propinsi &&
    telepon == other.telepon &&
    faksimile == other.faksimile &&
    website == other.website &&
    email == other.email &&
    pimpinan == other.pimpinan;
  }
  @override
  int get hashCode {
    return id.hashCode ^
    kode.hashCode ^
    nama.hashCode ^
    namaSingkat.hashCode ^
    urlLogo.hashCode ^
    status.hashCode ^
    skPendirian.hashCode ^
    tglSkPendirian.hashCode ^
    alamat.hashCode ^
    propinsi.hashCode ^
    telepon.hashCode ^
    faksimile.hashCode ^
    website.hashCode ^
    email.hashCode ^
    pimpinan.hashCode;
  }

}

class Alamat {
  Alamat({
    required this.jalan,
    required this.rt,
    required this.rw,
    required this.dusun,
    required this.kelurahan,
    required this.kodePos,
    required this.kabKota,
  });
  late final String jalan;
  late final String rt;
  late final String rw;
  late final String dusun;
  late final String kelurahan;
  late final String kodePos;
  late final KabKota kabKota;
  
  Alamat.fromJson(Map<String, dynamic> json){
    jalan = json['jalan'];
    rt = json['rt'];
    rw = json['rw'];
    dusun = json['dusun'];
    kelurahan = json['kelurahan'];
    kodePos = json['kode_pos'];
    kabKota = KabKota.fromJson(json['kab_kota']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['jalan'] = jalan;
    _data['rt'] = rt;
    _data['rw'] = rw;
    _data['dusun'] = dusun;
    _data['kelurahan'] = kelurahan;
    _data['kode_pos'] = kodePos;
    _data['kab_kota'] = kabKota.toJson();
    return _data;
  }

  @override
  bool operator ==(Object other) {
    return other is Alamat &&
    jalan == other.jalan &&
    rt == other.rt &&
    rw == other.rw &&
    dusun == other.dusun &&
    kelurahan == other.kelurahan &&
    kodePos == other.kodePos &&
    kabKota == other.kabKota;
  }
  @override
  int get hashCode {
    return jalan.hashCode ^ rt.hashCode ^ rw.hashCode ^ dusun.hashCode ^ kelurahan.hashCode ^ kodePos.hashCode ^ kabKota.hashCode;
  }

}

class KabKota {
  KabKota({
    required this.id,
    required this.nama,
  });
  late final String id;
  late final String nama;
  
  KabKota.fromJson(Map<String, dynamic> json){
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
  bool operator ==(Object other) {
    return other is KabKota &&
    id == other.id &&
    nama == other.nama;
  }
  @override
  int get hashCode {
    return id.hashCode ^ nama.hashCode;
  }

}

class Propinsi {
  Propinsi({
    required this.id,
    required this.nama,
  });
  late final String id;
  late final String nama;
  
  Propinsi.fromJson(Map<String, dynamic> json){
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
  bool operator ==(Object other) {
    return other is Propinsi &&
    id == other.id &&
    nama == other.nama;
  }
  @override
  int get hashCode {
    return nama.hashCode;
  }

}

class Pimpinan {
  Pimpinan({
    required this.nama,
  });
  late final String nama;
  
  Pimpinan.fromJson(Map<String, dynamic> json){
    nama = json['nama'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['nama'] = nama;
    return _data;
  }

  @override
  bool operator ==(Object other) {
    return other is Pimpinan &&
    nama == other.nama;
  }
  @override
  int get hashCode {
    return nama.hashCode;
  }

}