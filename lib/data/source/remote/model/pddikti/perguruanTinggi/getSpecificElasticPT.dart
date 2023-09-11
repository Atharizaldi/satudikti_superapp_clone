import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class GetSpecificElasticPT{
  GetSpecificElasticPT({
    required this.currentPage,
    required this.data,
    required this.maxPage,
    required this.message,
  });
  late final int currentPage;
  late final Data data;
  late final int maxPage;
  late final String message;
  
  GetSpecificElasticPT.fromJson(Map<String, dynamic> json){
    currentPage = json['current_page'];
    data = Data.fromJson(json['data']);
    maxPage = json['max_page'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['current_page'] = currentPage;
    _data['data'] = data.toJson();
    _data['max_page'] = maxPage;
    _data['message'] = message;
    return _data;
  }

  @override
  bool operator ==(Object other) =>
    other is GetSpecificElasticPT &&
    currentPage == other.currentPage &&
    data == other.data &&
    maxPage == other.maxPage &&
    message == other.message;

  @override
  int get hashCode => Object.hash( currentPage, data, maxPage, message);
}

class Data {
  Data({
    required this.pt,
  });
  late final List<Pt> pt;
  
  Data.fromJson(Map<String, dynamic> json){
    pt = List.from(json['pt']).map((e)=>Pt.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['pt'] = pt.map((e)=>e.toJson()).toList();
    return _data;
  }

  @override
  bool operator ==(Object other) {
    return other is Data &&
    IterableEquality().equals(pt, other.pt);
  }
  @override
  int get hashCode {
    return const IterableEquality().hash(pt);
  }
}

class Pt {
  Pt({
    required this.id,
    required this.nama,
    required this.singkatan,
     this.akreditas,
    required this.provinsi,
    required this.lintang,
    required this.bujur,
    required this.jln,
    required this.logo,
    required this.npsn,
    required this.website,
    required this.noTel,
    required this.jumlahProdi,
    required this.rasio,
  });
  late final String id;
  late final String nama;
  late final String singkatan;
  late final String? akreditas;
  late final String provinsi;
  late final dynamic lintang;
  late final dynamic bujur;
  late final String jln;
  late final String logo;
  late final String npsn;
  late final String website;
  late final String noTel;
  late final int jumlahProdi;
  late final List<Rasio> rasio;
  
  Pt.fromJson(Map<String, dynamic> json){
    id = json['id'];
    nama = json['nama'];
    singkatan = json['singkatan'];
    akreditas = null;
    provinsi = json['provinsi'];
    lintang = json['lintang'];
    bujur = json['bujur'];
    jln = json['jln'];
    logo = json['logo'];
    npsn = json['npsn'];
    website = json['website'];
    noTel = json['no_tel'];
    jumlahProdi = json['jumlah_prodi'];
    rasio = List.from(json['rasio']).map((e)=>Rasio.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['nama'] = nama;
    _data['singkatan'] = singkatan;
    _data['akreditas'] = akreditas;
    _data['provinsi'] = provinsi;
    _data['lintang'] = lintang;
    _data['bujur'] = bujur;
    _data['jln'] = jln;
    _data['logo'] = logo;
    _data['npsn'] = npsn;
    _data['website'] = website;
    _data['no_tel'] = noTel;
    _data['jumlah_prodi'] = jumlahProdi;
    _data['rasio'] = rasio.map((e)=>e.toJson()).toList();
    return _data;
  }

  @override
  bool operator ==(Object other) =>
    other is Pt &&
    id == other.id &&
    nama == other.nama &&
    singkatan == other.singkatan &&
    akreditas == other.akreditas &&
    provinsi == other.provinsi &&
    lintang == other.lintang &&
    bujur == other.bujur &&
    jln == other.jln &&
    logo == other.logo &&
    npsn == other.npsn &&
    website == other.website &&
    noTel == other.noTel &&
    jumlahProdi == other.jumlahProdi &&
    rasio == other.rasio;

  @override
  int get hashCode => Object.hash( id, nama, singkatan, akreditas,provinsi,lintang, bujur,
  jln, logo, npsn, website, noTel, jumlahProdi, rasio);
}

class Rasio {
  Rasio({
    required this.smt,
    required this.jmldosen,
    required this.jmlmhs,
  });
  late final String smt;
  late final int jmldosen;
  late final int jmlmhs;
  
  Rasio.fromJson(Map<String, dynamic> json){
    smt = json['smt'];
    jmldosen = json['jmldosen'];
    jmlmhs = json['jmlmhs'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['smt'] = smt;
    _data['jmldosen'] = jmldosen;
    _data['jmlmhs'] = jmlmhs;
    return _data;
  }

  @override
  bool operator ==(Object other) =>
     other is Rasio &&
    smt == other.smt &&
    jmldosen == other.jmldosen &&
    jmlmhs == other.jmlmhs;

  @override
  int get hashCode => Object.hash( smt, jmldosen, jmlmhs);
}