import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/pddikti/prodi/getRasioMhsDosen.dart';
import 'package:app/domain/repositories/pddiktiDetailRepository.dart';
import 'package:dartz/dartz.dart';

class GetRasioProdiAPI {
  PddiktiDetailRepository repository;
  GetRasioProdiAPI(this.repository);

  Future<Either<Failure, GetRasioMhsDosen>> execute(
      String kodeProdi, String kodePT) {
    return repository.getRasioProdiAPI(kodeProdi, kodePT);
  }
}
