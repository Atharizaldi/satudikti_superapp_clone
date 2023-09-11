import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/sister/bkd_rekrutmen_sister.dart';
import 'package:app/domain/repositories/sister_repository.dart';
import 'package:dartz/dartz.dart';

class GetBKDRekrutmenSister {
  final SisterRepository repo;

  GetBKDRekrutmenSister(this.repo);

  Future<Either<Failure, BKDRekrutmenSister>> execute(String nidn) {
    return repo.getBKDRekrutmen(nidn);
  }

  Future<Either<Failure, BKDPenilaianSister>> execute1(
      String nidn, String judul, String sortBy) {
    return repo.getBKDPenilaian(nidn, judul, sortBy);
  }
}
