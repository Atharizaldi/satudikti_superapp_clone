import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/pddikti/dosen/getSpecificDosen.dart';
import 'package:app/domain/repositories/pddiktiRepository.dart';
import 'package:dartz/dartz.dart';

class GetDetailDosenAPI {
  PddiktiRepository repository;
  GetDetailDosenAPI(this.repository);

  Future<Either<Failure, GetSpecificDosen>> execute(
      String nama, String nidn, String kodePT) {
    return repository.getDetailDosenAPI(nama, nidn, kodePT);
  }
}
