import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/gmagz/majalah_gmagz.dart';
import 'package:app/domain/repositories/GMagzRepository.dart';
import 'package:dartz/dartz.dart';

class GetMajalahGMagz {
  final GMagzRepository repository;

  GetMajalahGMagz(this.repository);

  Future<Either<Failure, MajalahGMagz>> execute(
      String sort, String judul, String displayby, int page) {
    return repository.getMajalah(sort, judul, displayby, page);
  }
}
