class ValidasiData {
  Data? data;
  String? message;
  bool? status;

  ValidasiData({this.data, this.message, this.status});

  ValidasiData.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    status = json['status'];
  }
}

class Data {
  String? alumniId;
  String? kodePt;
  String? kodeProdi;
  String? nama;
  String? nik;
  String? nim;
  String? tahunLulus;
  String? tangglLahir;
  String? noTlp;
  String? email;
  String? npwp;

  Data({
    this.alumniId,
    this.kodePt,
    this.kodeProdi,
    this.nama,
    this.nik,
    this.nim,
    this.tahunLulus,
    this.tangglLahir,
    this.noTlp,
    this.email,
    this.npwp,
  });

  Data.fromJson(Map<String, dynamic> json) {
    alumniId = json['id'];
    kodePt = json['kode_pt'];
    kodeProdi = json['kode_prodi'];
    nama = json['nama'];
    nik = json['nik'];
    nim = json['nim'];
    tahunLulus = json['tahun_lulus'];
    tangglLahir = json['tanggl_lahir'];
    noTlp = json['no_tlp'];
    email = json['email'];
    npwp = json['npwp'];
  }
}
