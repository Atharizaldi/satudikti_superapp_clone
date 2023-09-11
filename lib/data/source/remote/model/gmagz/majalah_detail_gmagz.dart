import 'package:equatable/equatable.dart';

class MajalahDetailGMagz extends Equatable {
  late final String message;
  late final DataMajalah dataMajalah;
  MajalahDetailGMagz({required this.message, required this.dataMajalah});

  MajalahDetailGMagz.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    dataMajalah = DataMajalah.fromJson(json['data']);
  }
  @override
  List<Object> get props => [message, dataMajalah];
}

class DataMajalah extends Equatable {
  late final DetailBook detailBook;
  late final List<Review> review;

  DataMajalah({required this.detailBook, required this.review});

  DataMajalah.fromJson(Map<String, dynamic> json) {
    detailBook = DetailBook.fromJson(json['detail_book']);

    review = List.from(json['review']).map((e) => Review.fromJson(e)).toList();
  }
  @override
  List<Object> get props => [detailBook, review];
}

class DetailBook extends Equatable {
  late final String idBook;
  late final String judul;
  late final String sinopsis;
  late final double rating;
  late final int jumlahUnduh;
  late final int jumlahBaca;
  late final int idStatPublikasi;
  late final int idKatPublikasi;
  late final UriFileCover uriFileCover;
  late final UriFileCover uriFileMajalah;
  late final int totalReview;

  DetailBook(
      {required this.idBook,
      required this.judul,
      required this.sinopsis,
      required this.rating,
      required this.jumlahBaca,
      required this.jumlahUnduh,
      required this.idStatPublikasi,
      required this.idKatPublikasi,
      required this.uriFileCover,
      required this.uriFileMajalah,
      required this.totalReview});

  DetailBook.fromJson(Map<String, dynamic> json) {
    idBook = json['id_book'] != null ? json['id_book'] : '';
    judul = json['judul'] != null ? json['judul'] : '';
    sinopsis = json['sinopsis'] != null ? json['sinopsis'] : '';
    rating = json['rating'] != null ? json['rating'].toDouble() : 0.0;
    jumlahBaca = json['jumlah_baca'] != null ? json['jumlah_baca'] : 0;
    jumlahUnduh = json['jumlah_unduh'] != null ? json['jumlah_unduh'] : 0;
    idStatPublikasi =
        json['id_stat_publikasi'] != null ? json['id_stat_publikasi'] : '';
    idKatPublikasi =
        json['id_kat_publikasi'] != null ? json['id_kat_publikasi'] : '';
    uriFileCover = UriFileCover.fromJson(json['uri_file_cover']);
    uriFileMajalah = UriFileCover.fromJson(json['uri_file_majalah']);
    totalReview = json['total_review'] != null ? json['total_review'] : 0;
  }
  @override
  List<Object> get props => [
        idBook,
        judul,
        sinopsis,
        rating,
        jumlahBaca,
        jumlahUnduh,
        idStatPublikasi,
        idKatPublikasi,
        uriFileCover,
        uriFileMajalah,
        totalReview
      ];
}

class UriFileCover extends Equatable {
  late final String namaDokumen;
  late final String filePath;

  UriFileCover({required this.namaDokumen, required this.filePath});

  UriFileCover.fromJson(Map<String, dynamic> json) {
    namaDokumen = json['nama_dokumen'] != null ? json['nama_dokumen'] : '';
    filePath = json['file_path'] != null ? json['file_path'] : '';
  }
  @override
  List<Object> get props => [namaDokumen, filePath];
}

class Review extends Equatable {
  late final String namaPengguna;
  late final int rating;
  late final String comment;
  late final String createDate;

  Review(
      {required this.namaPengguna,
      required this.rating,
      required this.comment,
      required this.createDate});

  Review.fromJson(Map<String, dynamic> json) {
    namaPengguna = json['nama_pengguna'] != null ? json['nama_pengguna'] : '';
    rating = json['rating'] != null ? json['rating'] : 0;
    comment = json['comment'] != null ? json['comment'] : '';
    createDate = json['create_date'] != null ? json['create_date'] : '';
  }
  @override
  List<Object> get props => [namaPengguna, rating, comment, createDate];
}
