import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/gmagz/downloader_gmagz.dart';
import 'package:app/domain/repositories/GMagzRepository.dart';
import 'package:dartz/dartz.dart';

class PutDownloaderGMAgz {
  final GMagzRepository repository;

  PutDownloaderGMAgz(this.repository);

  Future<Either<Failure, DownloaderGMagz>> execute(String id) {
    return repository.putDownloader(id);
  }
}
