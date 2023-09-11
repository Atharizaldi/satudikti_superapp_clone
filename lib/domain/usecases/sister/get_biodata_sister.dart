import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/sister/biodata_sister.dart';
import 'package:app/domain/repositories/sister_repository.dart';
import 'package:dartz/dartz.dart';

class GetBiodataSister {
  final SisterRepository repository;

  GetBiodataSister(this.repository);

  Future<Either<Failure, BiodataSister>> execute(String nidn) {
    return repository.getBiodata(nidn);
  }
}
