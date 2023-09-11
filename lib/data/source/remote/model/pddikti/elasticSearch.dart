import 'package:collection/collection.dart';

class ElasticSearch {
  Data? data;
  String? message;

  ElasticSearch({this.data, this.message});

  ElasticSearch.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }

  @override
  bool operator ==(Object other) =>
     other is ElasticSearch &&
        data == other.data &&
        message == other.message;

  @override
  int get hashCode => Object.hash( data, message);
}

class Data {
  Dashboard? dashboard;

  Data({this.dashboard});

  Data.fromJson(Map<String, dynamic> json) {
    dashboard = json['dashboard'] != null
        ? new Dashboard.fromJson(json['dashboard'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dashboard != null) {
      data['dashboard'] = this.dashboard!.toJson();
    }
    return data;
  }

  @override
  bool operator ==(Object other) {
    return other is Data && dashboard == other.dashboard;
  }
  @override
  int get hashCode {
    return dashboard.hashCode;
  }
}

class Dashboard {
  List<Pt>? pt;
  List<Prodi>? prodi;
  List<Dosen>? dosen;
  List<Mahasiswa>? mahasiswa;

  Dashboard({this.pt, this.prodi, this.dosen, this.mahasiswa});

  Dashboard.fromJson(Map<String, dynamic> json) {
    if (json['pt'] != null) {
      pt = <Pt>[];
      json['pt'].forEach((v) {
        pt!.add(new Pt.fromJson(v));
      });
    }
    if (json['prodi'] != null) {
      prodi = <Prodi>[];
      json['prodi'].forEach((v) {
        prodi!.add(new Prodi.fromJson(v));
      });
    }
    if (json['dosen'] != null) {
      dosen = <Dosen>[];
      json['dosen'].forEach((v) {
        dosen!.add(new Dosen.fromJson(v));
      });
    }
    if (json['mahasiswa'] != null) {
      mahasiswa = <Mahasiswa>[];
      json['mahasiswa'].forEach((v) {
        mahasiswa!.add(new Mahasiswa.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pt != null) {
      data['pt'] = this.pt!.map((v) => v.toJson()).toList();
    }
    if (this.prodi != null) {
      data['prodi'] = this.prodi!.map((v) => v.toJson()).toList();
    }
    if (this.dosen != null) {
      data['dosen'] = this.dosen!.map((v) => v.toJson()).toList();
    }
    if (this.mahasiswa != null) {
      data['mahasiswa'] = this.mahasiswa!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  bool operator ==(Object other) =>
    other is Dashboard &&
        IterableEquality().equals(pt, other.pt) &&
        IterableEquality().equals(prodi, other.prodi) &&
        IterableEquality().equals(dosen, other.dosen) &&
        IterableEquality().equals(mahasiswa, other.mahasiswa);

  @override
  int get hashCode => Object.hash( pt, prodi, dosen, mahasiswa);
}

class Pt {
  String? kodePt;
  String? nama;
  String? singkatan;
  String? akreditas;
  String? alamat;

  Pt({this.kodePt, this.nama, this.singkatan, this.akreditas, this.alamat});

  Pt.fromJson(Map<String, dynamic> json) {
    kodePt = json['kode_pt'];
    nama = json['nama'];
    singkatan = json['singkatan'];
    akreditas = json['akreditas'];
    alamat = json['alamat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kode_pt'] = this.kodePt;
    data['nama'] = this.nama;
    data['singkatan'] = this.singkatan;
    data['akreditas'] = this.akreditas;
    data['alamat'] = this.alamat;
    return data;
  }

  @override
  bool operator ==(Object other) =>
     other is Pt &&
        kodePt == other.kodePt &&
        nama == other.nama &&
        singkatan == other.singkatan &&
        akreditas == other.akreditas &&
        alamat == other.alamat;

  @override
  int get hashCode => Object.hash( kodePt, nama, singkatan, akreditas, alamat);
}

class Prodi {
  String? idReg;
  String? nama;
  String? lembaga;
  String? akreditas;
  String? jenjang;
  String? kodePt;
  String? kodeProdi;

  Prodi(
      {this.idReg,
      this.nama,
      this.lembaga,
      this.akreditas,
      this.jenjang,
      this.kodePt,
      this.kodeProdi});

  Prodi.fromJson(Map<String, dynamic> json) {
    idReg = json['id_reg'];
    nama = json['nama'];
    lembaga = json['lembaga'];
    akreditas = json['akreditas'];
    jenjang = json['jenjang'];
    kodePt = json['kode_pt'];
    kodeProdi = json['kode_prodi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_reg'] = this.idReg;
    data['nama'] = this.nama;
    data['lembaga'] = this.lembaga;
    data['akreditas'] = this.akreditas;
    data['jenjang'] = this.jenjang;
    data['kode_pt'] = this.kodePt;
    data['kode_prodi'] = this.kodeProdi;
    return data;
  }

  @override
  bool operator ==(Object other) =>
     other is Prodi &&
        idReg == other.idReg &&
        nama == other.nama &&
        lembaga == other.lembaga &&
        akreditas == other.akreditas &&
        jenjang == other.jenjang &&
        kodePt == other.kodePt &&
        kodeProdi == other.kodeProdi;

  @override
  int get hashCode => Object.hash( idReg, nama, lembaga, akreditas, jenjang, kodePt, kodeProdi);
}

class Dosen {
  String? nidn;
  String? nama;
  String? pt;
  String? prodi;

  Dosen({this.nidn, this.nama, this.pt, this.prodi});

  Dosen.fromJson(Map<String, dynamic> json) {
    nidn = json['nidn'];
    nama = json['nama'];
    pt = json['pt'];
    prodi = json['prodi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nidn'] = this.nidn;
    data['nama'] = this.nama;
    data['pt'] = this.pt;
    data['prodi'] = this.prodi;
    return data;
  }

  @override
  bool operator ==(Object other) =>
    other is Dosen &&
        nidn == other.nidn &&
        nama == other.nama &&
        pt == other.pt &&
        prodi == other.prodi;

  @override
  int get hashCode => Object.hash( nidn, nama, pt, prodi);
}

class Mahasiswa {
  String? idReg;
  String? nim;
  String? nama;
  String? pt;
  String? prodi;

  Mahasiswa({this.idReg, this.nim, this.nama, this.pt, this.prodi});

  Mahasiswa.fromJson(Map<String, dynamic> json) {
    idReg = json['id_reg'];
    nim = json['nim'];
    nama = json['nama'];
    pt = json['pt'];
    prodi = json['prodi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_reg'] = this.idReg;
    data['nim'] = this.nim;
    data['nama'] = this.nama;
    data['pt'] = this.pt;
    data['prodi'] = this.prodi;
    return data;
  }

  @override
  bool operator ==(Object other) =>
     other is Mahasiswa &&
        idReg == other.idReg &&
        nim == other.nim &&
        nama == other.nama &&
        pt == other.pt &&
        prodi == other.prodi;

  @override
  int get hashCode => Object.hash( idReg, nim, nama, pt, prodi);
}
