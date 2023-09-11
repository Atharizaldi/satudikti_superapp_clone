import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/pddikti/dosen/getRiwayatPendidikan.dart';
import 'package:app/domain/repositories/pddiktiDetailRepository.dart';
import 'package:dartz/dartz.dart';

class GetRiwayatPendidikanDosenAPI {
  PddiktiDetailRepository repository;
  GetRiwayatPendidikanDosenAPI(this.repository);

  Future<Either<Failure, RiwayatPendidikan>> execute(String nidn) async {
    return this.repository.getRiwayatPendidikanDosenAPI(nidn);
  }
}
