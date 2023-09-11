class DetailCeritaKampusMerdeka {
  late final String message;
  late final int status;
  late final DataDetailCerita dataDetailCerita;

  DetailCeritaKampusMerdeka({required this.message, required this.status});

  DetailCeritaKampusMerdeka.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    dataDetailCerita = DataDetailCerita.fromJson(json['data']);
  }
}

class DataDetailCerita {
  late final int id;
  late final String judul;
  late final String author;
  late final String tanggal;
  late final int nLikes;
  late final int nComment;
  late final String isiCerita;
  late final String fileCover;
  late final String urlCerita;

  DataDetailCerita({
    required this.id,
    required this.judul,
    required this.author,
    required this.tanggal,
    required this.nLikes,
    required this.nComment,
    required this.isiCerita,
    required this.fileCover,
    required this.urlCerita,
  });

  DataDetailCerita.fromJson(Map<String, dynamic> json) {
    id = json['id'] != null ? json['id'] : 0;
    judul = json['judul'] != null ? json['judul'] : '';
    author = json['author'] != null ? json['author'] : '';
    tanggal = json['tanggal'] != null ? json['tanggal'] : '';
    nLikes = json['n_likes'] != null ? json['n_likes'] : 0;
    nComment = json['n_komentar'] != null ? json['n_komentar'] : 0;
    isiCerita = json['isi_cerita'] != null ? json['isi_cerita'] : '';
    fileCover = json['file_cover'] != null ? json['file_cover'] : '';
    urlCerita = json['url_sumber'] != null ? json['url_sumber'] : '';
  }
}
