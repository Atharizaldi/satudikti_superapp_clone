import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/sister/pendidikan_pengajaran_sister.dart';
import 'package:app/domain/repositories/sister_repository.dart';
import 'package:dartz/dartz.dart';

class GetPendidikanPengajaranSister {
  final SisterRepository repository;

  GetPendidikanPengajaranSister(this.repository);

  Future<Either<Failure, PendidikanPengajaranSister>> execute(
      String nidn, String matkul, String displayBy) {
    return repository.getPendidikanPengajaran(nidn, matkul, displayBy);
  }
}
