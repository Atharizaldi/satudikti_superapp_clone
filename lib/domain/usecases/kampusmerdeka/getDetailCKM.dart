import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/kampusMerdeka/detail_ckm.dart';
import 'package:app/domain/repositories/kampusMerdekaRepository.dart';
import 'package:dartz/dartz.dart';

class GetDetailCKM {
  final KampusMerdekaRepository repository;

  GetDetailCKM(this.repository);

  Future<Either<Failure, DetailCeritaKampusMerdeka>> execute(String id) {
    return repository.getDetailCKM(id);
  }
}
