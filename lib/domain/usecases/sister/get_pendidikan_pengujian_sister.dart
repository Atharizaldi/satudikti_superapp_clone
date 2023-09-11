import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/sister/pendidikan_pengujian_sister.dart';
import 'package:app/domain/repositories/sister_repository.dart';
import 'package:dartz/dartz.dart';

class GetPendidikanPengujianSister {
  final SisterRepository repository;

  GetPendidikanPengujianSister(this.repository);

  Future<Either<Failure, PendidikanPengujianSister>> execute(
      String nidn, String displayBy, String judul) {
    return repository.getPendidikanPengujian(nidn, displayBy, judul);
  }
}
