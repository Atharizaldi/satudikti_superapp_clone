import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/sister/penelitian_sister.dart';
import 'package:app/domain/repositories/sister_repository.dart';
import 'package:dartz/dartz.dart';

class GetPenelitianSister {
  final SisterRepository repository;

  GetPenelitianSister(this.repository);

  Future<Either<Failure, PenelitianSister>> execute(String nidn) {
    return repository.getPenelitian(nidn);
  }
}
