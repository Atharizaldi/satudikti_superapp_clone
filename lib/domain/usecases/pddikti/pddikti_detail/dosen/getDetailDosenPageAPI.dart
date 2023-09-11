import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/pddikti/dosen/getDetailDosen.dart';
import 'package:app/domain/repositories/pddiktiDetailRepository.dart';
import 'package:dartz/dartz.dart';

class GetDetailDosenPageAPI {
  PddiktiDetailRepository repository;
  GetDetailDosenPageAPI(this.repository);

  Future<Either<Failure, GetDetailDosen>> execute(String nidn) async {
    return this.repository.getDetailDosenPageAPI(nidn);
  }
}
