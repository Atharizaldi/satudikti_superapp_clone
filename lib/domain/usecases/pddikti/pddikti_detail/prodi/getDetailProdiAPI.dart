import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/pddikti/prodi/getDetailProdi.dart';
import 'package:app/domain/repositories/pddiktiDetailRepository.dart';
import 'package:dartz/dartz.dart';

class GetDetailProdiAPI {
  PddiktiDetailRepository repository;
  GetDetailProdiAPI(this.repository);

  Future<Either<Failure, GetDetailProdi>> execute(
      String kodeProdi, String kodePT, bool fromPT) {
    return repository.getDetailProdiAPI(kodeProdi, kodePT, fromPT);
  }
}
