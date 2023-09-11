import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/pddikti/dosen/getRiwayatMengajar.dart';
import 'package:app/domain/repositories/pddiktiDetailRepository.dart';
import 'package:dartz/dartz.dart';

class GetRiwayatMengajarDosenAPI {
  PddiktiDetailRepository repository;
  GetRiwayatMengajarDosenAPI(this.repository);

  Future<Either<Failure, RiwayatMengajar>> execute(String nidn) async {
    return this.repository.getRiwayatMengajarDosenAPI(nidn);
  }
}
