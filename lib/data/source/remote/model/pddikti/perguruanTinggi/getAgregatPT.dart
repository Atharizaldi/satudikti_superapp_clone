import 'package:collection/collection.dart';

class GetAgregatPT {
  GetAgregatPT({
    required this.data,
    required this.message,
  });
  late final Data data;
  late final String message;

  GetAgregatPT.fromJson(Map<String, dynamic> json) {
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
    return other is GetAgregatPT &&
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
    required this.agregatDosen,
  });
  late final AgregatDosen agregatDosen;

  Data.fromJson(Map<String, dynamic> json) {
    agregatDosen = AgregatDosen.fromJson(json['agregat_dosen']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['agregat_dosen'] = agregatDosen.toJson();
    return _data;
  }

  @override
  bool operator ==(Object other) {
    return other is Data && agregatDosen == other.agregatDosen;
  }
  @override
  int get hashCode {
    return agregatDosen.hashCode;
  }

}

class AgregatDosen {
  AgregatDosen({
    required this.dosenTetap,
    required this.dosenTidakTetap,
  });
  late final DosenTetap dosenTetap;
  late final DosenTidakTetap dosenTidakTetap;

  AgregatDosen.fromJson(Map<String, dynamic> json) {
    dosenTetap = DosenTetap.fromJson(json['dosen_tetap']);
    dosenTidakTetap = DosenTidakTetap.fromJson(json['dosen_tidak_tetap']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['dosen_tetap'] = dosenTetap.toJson();
    _data['dosen_tidak_tetap'] = dosenTidakTetap.toJson();
    return _data;
  }

  @override
  bool operator ==(Object other) {
    return other is AgregatDosen &&
        dosenTetap == other.dosenTetap &&
        dosenTidakTetap == other.dosenTidakTetap;
  }

  @override
  int get hashCode {
    return dosenTetap.hashCode ^ dosenTidakTetap.hashCode;
  }

}

class DosenTetap {
  DosenTetap({
    required this.registrasi,
    required this.jabatan,
    required this.jenjang,
  });
  late final List<Registrasi> registrasi;
  late final List<Jabatan> jabatan;
  late final List<Jenjang> jenjang;

  DosenTetap.fromJson(Map<String, dynamic> json) {
    registrasi = List.from(json['registrasi'])
        .map((e) => Registrasi.fromJson(e))
        .toList();
    jabatan =
        List.from(json['jabatan']).map((e) => Jabatan.fromJson(e)).toList();
    jenjang =
        List.from(json['jenjang']).map((e) => Jenjang.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['registrasi'] = registrasi.map((e) => e.toJson()).toList();
    _data['jabatan'] = jabatan.map((e) => e.toJson()).toList();
    _data['jenjang'] = jenjang.map((e) => e.toJson()).toList();
    return _data;
  }

  @override
  bool operator ==(Object other) {
    return other is DosenTetap &&
        IterableEquality().equals(registrasi, other.registrasi) &&
        IterableEquality().equals(jabatan, other.jabatan) &&
        IterableEquality().equals(jenjang, other.jenjang);
  }
  @override
  int get hashCode {
    final hash = IterableEquality().hash;
    return hash(registrasi) ^ hash(jabatan) ^ hash(jenjang);
  }
}

class Registrasi {
  Registrasi({
    required this.nama,
    required this.jumlahDosen,
  });
  late final String nama;
  late final int jumlahDosen;

  Registrasi.fromJson(Map<String, dynamic> json) {
    nama = json['nama'];
    jumlahDosen = json['jumlah_dosen'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['nama'] = nama;
    _data['jumlah_dosen'] = jumlahDosen;
    return _data;
  }

  @override
  bool operator ==(Object other) {
    return other is Registrasi &&
        nama == other.nama &&
        jumlahDosen == other.jumlahDosen;
  }
  @override
  int get hashCode {
    return nama.hashCode ^ jumlahDosen.hashCode;
  }

}

class Jabatan {
  Jabatan({
    required this.nama,
    required this.jumlahDosen,
  });
  late final String nama;
  late final int jumlahDosen;

  Jabatan.fromJson(Map<String, dynamic> json) {
    nama = json['nama'];
    jumlahDosen = json['jumlah_dosen'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['nama'] = nama;
    _data['jumlah_dosen'] = jumlahDosen;
    return _data;
  }

  @override
  bool operator ==(Object other) {
    return other is Jabatan &&
        nama == other.nama &&
        jumlahDosen == other.jumlahDosen;
  }
  @override
  int get hashCode {
    return nama.hashCode ^ jumlahDosen.hashCode;
  }
}

class Jenjang {
  Jenjang({
    required this.nama,
    required this.jumlahDosen,
  });
  late final String nama;
  late final int jumlahDosen;

  Jenjang.fromJson(Map<String, dynamic> json) {
    nama = json['nama'];
    jumlahDosen = json['jumlah_dosen'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['nama'] = nama;
    _data['jumlah_dosen'] = jumlahDosen;
    return _data;
  }

  @override
  bool operator ==(Object other) =>
     other is Jenjang &&
        nama == other.nama &&
        jumlahDosen == other.jumlahDosen;

  @override
  int get hashCode => Object.hash( nama, jumlahDosen);
}

class DosenTidakTetap {
  DosenTidakTetap({
    required this.registrasi,
    required this.jabatan,
    required this.jenjang,
  });
  late final List<Registrasi> registrasi;
  late final List<Jabatan> jabatan;
  late final List<Jenjang> jenjang;

  DosenTidakTetap.fromJson(Map<String, dynamic> json) {
    registrasi = List.from(json['registrasi'])
        .map((e) => Registrasi.fromJson(e))
        .toList();
    jabatan =
        List.from(json['jabatan']).map((e) => Jabatan.fromJson(e)).toList();
    jenjang =
        List.from(json['jenjang']).map((e) => Jenjang.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['registrasi'] = registrasi.map((e) => e.toJson()).toList();
    _data['jabatan'] = jabatan.map((e) => e.toJson()).toList();
    _data['jenjang'] = jenjang.map((e) => e.toJson()).toList();
    return _data;
  }

  @override
  bool operator ==(Object other) =>
     other is DosenTidakTetap &&
        IterableEquality().equals(registrasi, other.registrasi) &&
        IterableEquality().equals(jabatan, other.jabatan) &&
        IterableEquality().equals(jenjang, other.jenjang);

  @override
  int get hashCode => Object.hash( registrasi, jabatan, jenjang);
}
