import 'package:equatable/equatable.dart';

class MajalahGMagz extends Equatable {
  late final String message;
  late final Data data;
  MajalahGMagz({required this.message, required this.data});

  MajalahGMagz.fromJson(Map<String, dynamic> json) {
    message = json['message'];

    data = Data.fromJson(json['data']);
  }

  @override
  List<Object> get props => [message, data];
}

class Data extends Equatable {
  late final int totalRowCount;

  late final int rowCount;
  late final List<ListBook> listBook;

  Data(
      {required this.listBook,
      required this.rowCount,
      required this.totalRowCount});

  Data.fromJson(Map<String, dynamic> json) {
    totalRowCount =
        json['total_row_count'] != null ? json['total_row_count'] : 0;
    rowCount = json['row_count'];
    listBook =
        List.from(json['list_book']).map((e) => ListBook.fromJson(e)).toList();
  }

  @override
  List<Object> get props => [listBook, rowCount, totalRowCount];
}

class ListBook extends Equatable {
  late final String idBook;
  late final int idKatPublikasi;
  late final String judul;
  late final String sinopsis;
  late final int tahun;
  late final double rating;
  late final int idStatPublikasi;
  late final int totalReview;
  late final UriCover uriCover;

  ListBook(
      {required this.idBook,
      required this.idKatPublikasi,
      required this.judul,
      required this.sinopsis,
      required this.tahun,
      required this.rating,
      required this.idStatPublikasi,
      required this.totalReview,
      required this.uriCover});

  ListBook.fromJson(Map<String, dynamic> json) {
    idBook = json['id_book'] != null ? json['id_book'] : '';
    idKatPublikasi =
        json['id_kat_publikasi'] != null ? json['id_kat_publikasi'] : 0;
    judul = json['judul'] != null ? json['judul'] : '';
    sinopsis = json['sinopsis'] != null ? json['sinopsis'] : '';
    tahun = json['tahun'] != null ? json['tahun'] : 0;
    rating = json['rating'] != null ? json['rating'].toDouble() : 0.0;
    idStatPublikasi =
        json['id_stat_publikasi'] != null ? json['id_stat_publikasi'] : 0;
    totalReview = json['total_review'] != null ? json['total_review'] : 0;
    uriCover = (json['uri_cover'] != null
        ? new UriCover.fromJson(json['uri_cover'])
        : null)!;
  }

  @override
  List<Object> get props => [
        idBook,
        idKatPublikasi,
        judul,
        sinopsis,
        tahun,
        rating,
        idStatPublikasi,
        totalReview,
        uriCover
      ];
}

class UriCover extends Equatable {
  late final String namaDokumen;
  late final String filePath;

  UriCover({required this.namaDokumen, required this.filePath});

  UriCover.fromJson(Map<String, dynamic> json) {
    namaDokumen = json['nama_dokumen'] != null ? json['nama_dokumen'] : '';
    filePath = json['file_path'] != null ? json['file_path'] : '';
  }

  @override
  List<Object> get props => [namaDokumen, filePath];
}
