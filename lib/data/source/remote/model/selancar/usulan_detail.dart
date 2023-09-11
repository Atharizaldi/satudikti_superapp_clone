class UsulanDetail {
  UsulanDetail({
    required this.detailUsulan,
    required this.message,
    required this.progressPercentage,
  });
  late final List<DetailUsulan> detailUsulan;
  late final String message;
  late final num progressPercentage;

  UsulanDetail.fromJson(Map<String, dynamic> json) {
    detailUsulan = List.from(json['data']['progress'])
        .map((e) => DetailUsulan.fromJson(e))
        .toList();
    message = json['message'];
    progressPercentage = json['data']['percent'];
  }
}

class DetailUsulan {
  DetailUsulan({
    required this.status,
    required this.kelas,
    required this.judul,
    required this.deskripsi,
    required this.tanggal,
  });
  late final String status;
  late final String kelas;
  late final String judul;
  late final String deskripsi;
  late final String tanggal;

  DetailUsulan.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    kelas = json['class'];
    judul = json['title'];
    deskripsi = json['description'];
    tanggal = json['updated_date'];
  }
}
