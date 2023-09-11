import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/pddikti/prodi/getListDosenProdi.dart';
import 'package:app/domain/repositories/pddiktiDetailRepository.dart';
import 'package:dartz/dartz.dart';

class GetListDosenProdiAPI {
  PddiktiDetailRepository repository;
  GetListDosenProdiAPI(this.repository);

  Future<Either<Failure, GetListDosenProdi>> execute(
      String kodeProdi, String kodePT) {
    return repository.getListDosenProdiAPI(kodeProdi, kodePT);
  }
}
