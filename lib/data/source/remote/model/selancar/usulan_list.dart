class UsulanList {
  UsulanList({
    required this.usulan,
    required this.message,
  });
  late final List<Usulan> usulan;
  late final String message;

  UsulanList.fromJson(Map<String, dynamic> json) {
    usulan = List.from(json['data']).map((e) => Usulan.fromJson(e)).toList();
    message = json['message'];
  }
}

class Usulan {
  Usulan({
    required this.id,
    required this.namaUsulan,
    required this.nomorSurat,
    required this.tanggalSurat,
    required this.jenisPengajuan,
  });
  late final String id;
  late final String namaUsulan;
  late final String nomorSurat;
  late final String tanggalSurat;
  late final String jenisPengajuan;

  Usulan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaUsulan = json['usulan'];
    nomorSurat = json['no_surat'];
    tanggalSurat = json['tgl_surat'];
    jenisPengajuan = json['category'];
  }
}
