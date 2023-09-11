class GetListProdi {
  GetListProdi({
    required this.data,
    required this.message,
  });
  late final Data data;
  late final String message;
  
  GetListProdi.fromJson(Map<String, dynamic> json){
    try {
      data = Data.fromJson(json['data']);
    } catch (e) {
      data = Data.forNull();
    }
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
    required this.prodi,
  });
  late final List<Prodi> prodi;
  
  Data.fromJson(Map<String, dynamic> json){
    prodi = List.from(json['prodi']).map((e)=>Prodi.fromJson(e)).toList();
  }

  Data.forNull(){
    prodi = [];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['prodi'] = prodi.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Prodi {
  Prodi({
    required this.id,
    required this.kode,
    required this.nama,
    required this.status,
    required this.akreditasi,
    required this.jenjangDidik,
    required this.pt,
  });
  late final String id;
  late final String kode;
  late final String nama;
  late final String status;
  late final String akreditasi;
  late final JenjangDidik jenjangDidik;
  late final Pt pt;
  
  Prodi.fromJson(Map<String, dynamic> json){
    id = json['id'];
    kode = json['kode'];
    nama = json['nama'];
    status = json['status'];
    akreditasi = json['akreditasi'];
    jenjangDidik = JenjangDidik.fromJson(json['jenjang_didik']);
    pt = Pt.fromJson(json['pt']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['kode'] = kode;
    _data['nama'] = nama;
    _data['status'] = status;
    _data['akreditasi'] = akreditasi;
    _data['jenjang_didik'] = jenjangDidik.toJson();
    _data['pt'] = pt.toJson();
    return _data;
  }
}

class JenjangDidik {
  JenjangDidik({
    required this.id,
    required this.nama,
  });
  late final int id;
  late final String nama;
  
  JenjangDidik.fromJson(Map<String, dynamic> json){
    id = json['id'];
    nama = json['nama'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['nama'] = nama;
    return _data;
  }
}

class Pt {
  Pt({
    required this.id,
    required this.kode,
    required this.nama,
  });
  late final String id;
  late final String kode;
  late final String nama;
  
  Pt.fromJson(Map<String, dynamic> json){
    id = json['id'];
    kode = json['kode'];
    nama = json['nama'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['kode'] = kode;
    _data['nama'] = nama;
    return _data;
  }
}