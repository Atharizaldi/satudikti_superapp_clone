import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/gmagz/downloader_gmagz.dart';
import 'package:app/data/source/remote/model/gmagz/majalah_detail_gmagz.dart';
import 'package:app/data/source/remote/model/gmagz/majalah_gmagz.dart';
import 'package:dartz/dartz.dart';

abstract class GMagzRepository {
  // Future<Either<Failure,
  Future<Either<Failure, MajalahGMagz>> getMajalah(
      String sort, String judul, String displayby, int page);

  Future<Either<Failure, MajalahDetailGMagz>> getMajalahDetail(String id);

  Future<Either<Failure, DownloaderGMagz>> putDownloader(String id);

  Future<Either<Failure, DownloaderGMagz>> putReader(String id);
}
