import 'package:app/common/failure.dart';
import 'package:app/data/source/remote/model/pddikti/prodi/getSpecificElasticProdi.dart';
import 'package:app/domain/repositories/pddiktiRepository.dart';
import 'package:dartz/dartz.dart';

class GetProdiAPI {
  PddiktiRepository repository;
  GetProdiAPI(this.repository);

  Future<Either<Failure, GetSpecificElasticProdi>> execute(
      String namaProdi, String kodePT, String akreditasi, String jenjang) {
    return repository.getProdiAPI(namaProdi, kodePT, akreditasi, jenjang);
  }
}
