class ProdiPTLN {
  String? message;
  Data? data;

  ProdiPTLN({this.message, this.data});

  ProdiPTLN.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Prodi>? prodi;

  Data({this.prodi});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['prodi'] != null) {
      prodi = <Prodi>[];
      json['prodi'].forEach((v) {
        prodi!.add(new Prodi.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.prodi != null) {
      data['prodi'] = this.prodi!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Prodi {
  String? no;
  String? namaProdi;

  Prodi({this.no, this.namaProdi});

  Prodi.fromJson(Map<String, dynamic> json) {
    no = json['no'];
    namaProdi = json['nama_prodi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['no'] = this.no;
    data['nama_prodi'] = this.namaProdi;
    return data;
  }
}

