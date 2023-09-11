class CeritaKampusMerdeka {
  late final List<ListCKM> listCKM;

  CeritaKampusMerdeka(
      {required this.listCKM});

  CeritaKampusMerdeka.fromJson(Map<String, dynamic> json) {
    listCKM = List.from(json['data'])
        .map((e) => ListCKM.fromJson(e))
        .toList();
  }
}

class ListCKM {
  late final int id;
  late final int idProgram;
  late final String judul;
  late final String author;
  late final String tanggal;
  late final int nLikes;
  late final int nComment;
  late final String fileCover;

  ListCKM({
    required this.id,
    required this.idProgram,
    required this.judul,
    required this.author,
    required this.tanggal,
    required this.nLikes,
    required this.nComment,
    required this.fileCover
});

  ListCKM.fromJson(Map<String, dynamic>json) {
    id = json['id'] != null ? json['id'] : 0;
    idProgram = json['id_program'] != null ? json['id_program'] : 0;
    judul = json['judul'] != null ? json['judul'] : '';
    author = json['author'] != null ? json['author'] : '';
    tanggal = json['tanggal'] != null ? json['tanggal'] : '';
    nLikes = json['n_likes'] != null ? json['n_likes'] : 0;
    nComment = json['n_komentar'] != null ? json['n_komentar'] : 0;
    fileCover = json['file_cover'] != null ? json['file_cover'] : '';
  }
}
