import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/sister/pendidikan_formal_dosen_sister.dart';
import 'package:app/domain/repositories/sister_repository.dart';
import 'package:dartz/dartz.dart';

class GetPendidikanFormalDosenSister {
  final SisterRepository repository;

  GetPendidikanFormalDosenSister(this.repository);

  Future<Either<Failure, PendidikanFormalDosenSister>> execute(String nidn) {
    return repository.getPendidikanFormalDosen(nidn);
  }
}
