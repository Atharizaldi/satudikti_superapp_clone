import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/sister/pendidikan_diklat_sister.dart';
import 'package:app/domain/repositories/sister_repository.dart';
import 'package:dartz/dartz.dart';

class GetPendidikanDiklatSister {
  final SisterRepository repository;

  GetPendidikanDiklatSister(this.repository);

  Future<Either<Failure, PendidikanDiklatSister>> execute(
      String nidn, String displayBy, String judul) {
    return repository.getPendidikanDiklat(nidn, displayBy, judul);
  }
}
