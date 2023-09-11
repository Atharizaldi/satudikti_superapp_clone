import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/sister/penempatan_sister.dart';
import 'package:app/domain/repositories/sister_repository.dart';
import 'package:dartz/dartz.dart';

class GetPenempatanSister {
  final SisterRepository repository;

  GetPenempatanSister(this.repository);

  Future<Either<Failure, PenempatanSister>> execute(String nidn) {
    return repository.getPenempatan(nidn);
  }
}
