import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/gmagz/majalah_detail_gmagz.dart';
import 'package:app/domain/repositories/GMagzRepository.dart';
import 'package:dartz/dartz.dart';

class GetMajalahDetailGMagz {
  final GMagzRepository repository;

  GetMajalahDetailGMagz(this.repository);

  Future<Either<Failure, MajalahDetailGMagz>> execute(String id) {
    return repository.getMajalahDetail(id);
  }
}
