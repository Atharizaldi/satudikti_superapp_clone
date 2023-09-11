import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/sister/pendidikan_pembimbingan_sister.dart';
import 'package:app/domain/repositories/sister_repository.dart';
import 'package:dartz/dartz.dart';

class GetPendidikanPembimbinganSister {
  final SisterRepository repository;

  GetPendidikanPembimbinganSister(this.repository);

  Future<Either<Failure, PendidikanPembimbinganSister>> execute(
      String nidn, String displayBy, String judul) {
    return repository.getPendidikanPembimbingan(nidn, displayBy, judul);
  }
}
